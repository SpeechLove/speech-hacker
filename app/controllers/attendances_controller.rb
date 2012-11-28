class AttendancesController < ApplicationController
	def create
		if (params[:attend] == "false") 
			user_meeting_role_id = MeetingRole.find_by_title("Absentee").id
			notice = "Sorry you're not coming."
		else
			if params[:attendance][:meeting_role_id]
				user_meeting_role_id = params[:attendance][:meeting_role_id].to_i
			else
			  user_meeting_role_id = MeetingRole.find_by_title("Attendee").id
			end
			notice = "See you there!"
		end
		attendance_params = params[:attendance]
		attendance_params[:user_id] = current_user.id
		attendance_params[:meeting_role_id] = user_meeting_role_id
		@attendance = Attendance.new(attendance_params )
		if @attendance.save
			redirect_to meetings_path(params[:attendance][:meeting_id]), :notice => notice
		else
			render 'index', :alert => "Something went wrong!"
		end
	end
end
