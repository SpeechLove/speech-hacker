module ApplicationHelper
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

  def attendee_meeting_roles
    MeetingRole.attendee_roles
  end

  def create_meeting_link
    if can? :manage, Meeting
      link_to "Create Meeting", new_meeting_path
    end
  end

  def manage_users_link
    if can? :manage, User
      link_to "Members", users_path
    end
  end

  def manage_meeting_roles_link
    if can? :read, MeetingRole
      link_to "Meeting Roles", meeting_roles_path
    end
  end
end
