module MeetingsHelper
  def meeting_title(meeting)
    if meeting.happened?
      "Meeting Agenda"
    else
      "Meeting Sign-up"
    end
  end

  def edit_meeting_link(meeting)
    if user_signed_in? && (can? :update, meeting)
      link_to "Edit", edit_meeting_path(meeting)
    end
  end

  def cancel_meeting_header(meeting)
    if can? :destroy, meeting
      "Cancel Meeting?"
    end
  end

  def cancel_meeting_link(meeting)
    if can? :destroy, meeting
      link_to "Cancel", meeting_path(meeting), :method => :delete
    end
  end

  def meeting_description(meeting)
    if meeting.description
      meeting.description.capitalize
    end
  end
end
