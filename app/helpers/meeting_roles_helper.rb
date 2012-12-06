module MeetingRolesHelper
  def edit_meeting_role_link(meeting_role)
    unless meeting_role.required_role?
      link_to "<i class=\"icon-pencil\"></i> Edit".html_safe, edit_meeting_role_path(meeting_role), :remote => true
    end
  end

  def delete_meeting_role_link(meeting_role)
    unless meeting_role.required_role?
      link_to "<i class=\"icon-remove\"></i> Destroy".html_safe, meeting_role_path(meeting_role), :method => :delete, :remote => true,
                         :confirm => "Are you sure you want to delete this role?"
    end
  end
end
