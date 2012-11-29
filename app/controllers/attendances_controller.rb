class AttendancesController < ApplicationController
  def create
    @meeting = Meeting.find(params[:meeting_id])
    @attendance = Attendance.new(params[:attendance].merge(:meeting => @meeting, :user => current_user))
    if @attendance.save
      redirect_to meetings_path(params[:attendance][:meeting_id]), :notice => notice
    else
      redirect_to meetings_path, :alert => "Something went wrong!"
    end
  end

  def update
    @attendance = current_user.attendances.find(params[:id])
    @attendance.update_attributes(params[:attendance])
    redirect_to meetings_path, :notice => "Your information was updated."
  end
end
