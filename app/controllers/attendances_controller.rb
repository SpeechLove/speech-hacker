class AttendancesController < ApplicationController
  def create
    @meeting = Meeting.find(params[:meeting_id])
    @attendance = Attendance.new(params[:attendance].merge(:meeting => @meeting, :user => current_user))
    params[:attendance][:attend] == "true" ? notice = "See you there!" : notice = "Sorry you won't be there."

    if @attendance.save
      redirect_to meetings_path(params[:attendance][:meeting_id]), :notice => notice
    else
      redirect_to meetings_path, :alert => "Something went wrong!"
    end
  end

  def update
    params[:attendance][:attend] == "true" ? notice = "See you there!" : notice = "Sorry you won't be there."
    @attendance = current_user.attendances.find(params[:id])
    @attendance.update_attributes(params[:attendance])
    redirect_to meetings_path, :notice => notice
  end
end
