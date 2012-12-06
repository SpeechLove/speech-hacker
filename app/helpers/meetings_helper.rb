module MeetingsHelper
  def meeting_title(meeting)
    if meeting.happened?
      "Meeting Agenda"
    else
      "Meeting Sign-up"
    end
  end

  def meeting_index_action(meeting)
    if meeting.happened?
      action_title = "View agenda"
      button_class = "inverse"
    else
      action_title = "Sign up for a role"
      button_class = "primary"
    end
    button_to action_title, meeting_path(meeting), :class => "btn btn-#{button_class}", :method => :get
  end

  def cancel_meeting_header(meeting)
    if can? :destroy, meeting
      "Cancel Meeting?"
    end
  end

  def cancel_meeting_button(meeting)
    if can? :destroy, meeting
      button_to "Cancel", meeting_path(meeting), :class => "btn btn-danger",
                                                 :method => :delete,
                                                 :confirm => "Are you sure you want to cancel this meeting?"
    end
  end
end
