module ApplicationHelper
	def current_project(meeting)
		user_speech = current_speech(meeting)
		user_speech.present? ? user_speech.project_id : "" 
	end

	def current_speech(meeting)
		current_user.meeting_speech(meeting)
	end

	def user_attending?(meeting)
		current_user.attending?(meeting)
	end
end
