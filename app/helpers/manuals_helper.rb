module ManualsHelper
  def project_completed_date(speech)
    if speech.meeting
      speech.meeting.formatted_short_date
    else
      "Unknown meeting"
    end
  end
end
