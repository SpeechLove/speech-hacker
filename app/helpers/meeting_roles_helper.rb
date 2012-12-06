module MeetingRolesHelper
  def edit_meeting_role_link(meeting_role)
    unless meeting_role.required_role?
      link_to "Edit", edit_meeting_role_path(meeting_role), :remote => true
    end
  end

  def delete_meeting_role_link(meeting_role)
    unless meeting_role.required_role?
      link_to "Destroy", meeting_role_path(meeting_role), :method => :delete, :remote => true,
                         :confirm => "Are you sure you want to delete this role?"
    end
  end
end
