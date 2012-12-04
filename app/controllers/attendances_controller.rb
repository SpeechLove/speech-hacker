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
    @role = MeetingRole.find(params[:role_id])

    if params[:old_user_id] == ""
      success = add_new_attendance(@meeting, @user, @role)
    elsif params[:old_user_id] != "" && params[:user_id] == ""
      # Change old_user to Attendee
      @old_user = User.find(params[:old_user_id])
      success = update_attendance(@meeting, @old_user, @old_user, MeetingRole.attendee)
    else
      @user = User.find(params[:user_id])
      @old_user = User.find(params[:old_user_id])
      success = update_attendance(@meeting, @old_user, @user, @role)
    end

    respond_to do |format|
      format.json do
        if success
          render :json => { :success => true }
        else
          # TODO: get errors from the correc object
          render :json => {
                            :errors => success.errors.full_messages.join(', '),
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

  def update_attendance(meeting, old_user, user, meeting_role)
    attendance = meeting.attendances.where(:user_id => old_user.id).first
    attendance.update_attributes(:attend => "true", :user => user, :meeting_role => meeting_role,
                                 :meeting_role_id => meeting_role.id)
  end
end
