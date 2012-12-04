class AttendancesController < ApplicationController
  def create
    @meeting = Meeting.find(params[:meeting_id])
    params[:attendance].merge!(:meeting => @meeting, :user => current_user)
    @attendance = Attendance.new(params[:attendance])

    if @attendance.save
      notice = @attendance.attend ? "See you there!" : "Sorry you won't be there."
      redirect_to meetings_path(@meeting), :notice => notice
    else
      @meeting_roles = MeetingRole.attendee_roles
      render "meetings/show", :alert => "Something went wrong!"
    end
  end

  def update
    @attendance = current_user.attendances.find(params[:id])

    if @attendance.update_attributes(params[:attendance])
      # if role changed from speaker to non-speaker, remove db record

      notice = @attendance.attend ? "See you there!" : "Sorry you won't be there."
      redirect_to meetings_path, :notice => notice
    else
      @meeting = @attendance.meeting
      @meeting_roles = MeetingRole.attendee_roles
      render "meetings/show", :alert => "Something went wrong!"
    end
  end

  def update_role
    logger.info("-------- update role ----------")
    logger.info(params)

    @meeting = Meeting.find(params[:id])
    @user = User.find(params[:user_id])
    @role = MeetingRole.find(params[:role_id])

    if params[:old_user_id] == ""
      success = add_new_attendance(@meeting, @user, @role)
    else
      @old_user = User.find(params[:old_user_id])
      @attendance = @meeting.attendances.where(:user_id => @old_user.id).first
      success = @attendance.update_attributes(:attend => "true", :user => @user)
    end

    respond_to do |format|
      format.json do
        if success
          render :json => { :success => true }
        else
          logger.info(@attendance.errors.full_messages)
          render :json => {
                            :errors => @attendance.errors.full_messages.join(', '),
                            :status => :unprocessable_entity
                          }
        end
      end
    end
  end

  private

  def add_new_attendance(meeting, user, role)
    Attendance.create(:attend => "true", :user => user, :meeting_role => role,
                      :meeting => meeting)
  end
end
