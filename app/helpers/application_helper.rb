module ApplicationHelper
	def current_project(meeting)
		user_speech = current_speech(meeting)
		user_speech.present? ? user_speech.project_id : "" 
	end

	def current_speech(meeting)
		current_user.meeting_speech(meeting) || current_user.speeches.build
	end

	def current_manual(meeting)
    current_speech(meeting).project.present? ? current_speech(meeting).project.manual : Manual.first
	end

	def user_attending?(meeting)
		current_user.attending?(meeting)
	end

	def project_select(meeting)
		Project.find_all_by_manual_id(current_manual(meeting).id)
	end
end
