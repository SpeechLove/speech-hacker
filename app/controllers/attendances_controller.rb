class AttendancesController < ApplicationController
  def create
    @meeting = Meeting.find(params[:meeting_id])
    params[:attendance].merge!(:meeting => @meeting, :user => current_user)
    @attendance = Attendance.new(params[:attendance])

    if @attendance.save
      notice = @attendance.attend? ? "See you there!" : "Sorry you won't be there."
      redirect_to meetings_path, :notice => notice
    else
      @meeting_roles = MeetingRole.attendee_roles
      render "meetings/show", :alert => "Something went wrong!"
    end
  end

  def update
    @attendance = current_user.attendances.find(params[:id])

    if @attendance.update_attributes(params[:attendance])
      # TODO: if role changed from speaker to non-speaker, remove db record

      notice = @attendance.attend? ? "See you there!" : "Sorry you won't be there."
      redirect_to meetings_path, :notice => notice
    else
      @meeting = @attendance.meeting
      @meeting_roles = MeetingRole.attendee_roles
      render "meetings/show", :alert => "Something went wrong!"
    end
  end
end
