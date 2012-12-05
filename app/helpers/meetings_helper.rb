module MeetingsHelper
  def meeting_title(meeting)
    if meeting.happened?
      "Meeting Agenda"
    else
      "Meeting Sign-up"
    end
  end
end
