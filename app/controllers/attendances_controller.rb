class AttendancesController < ApplicationController
	def create
		logger.info("-------------- attendance create -------------")
		logger.info(params)
		if (params[:attend] == false) 
			user_meeting_role_id = MeetingRole.find_by_title("Absentee").id
		else
			if params[:attendance][:meeting_role_id]
				user_meeting_role_id = params[:attendance][:meeting_role_id].to_i
			else
			  user_meeting_role_id = MeetingRole.find_by_title("Attendee").id
			end
		end
		attendance_params = params[:attendance]
		attendance_params[:user_id] = current_user.id
		attendance_params[:meeting_role_id] = user_meeting_role_id
		@attendance = Attendance.create(attendance_params)
	end
end
