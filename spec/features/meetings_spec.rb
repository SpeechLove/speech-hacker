require 'spec_helper'

describe "Meetings", :js => true do
  let!(:meeting) { Fabricate(:meeting) }

  describe "view meetings" do
    it "shows meeting date and time for each meeting" do
      visit meetings_path
      page.should have_link meeting.meeting_date.strftime("%m/%d/%Y")
      page.should have_content meeting.meeting_time
    end
  end

  describe "create and edit meetings" do
    let!(:meeting) { Fabricate(:meeting) }

    it "creates a meeting" do
      # admin needs to be signed in
      visit new_meeting_path
      fill_in 'meeting_meeting_date', :with => meeting.meeting_date
      fill_in 'meeting_meeting_time', :with => meeting.meeting_time
      click_button "Create Meeting"
      page.should have_content meeting.meeting_time
    end

    it "edits a meeting" do
      # admin needs to be signed in
      visit edit_meeting_path(meeting.id)
      fill_in 'meeting_meeting_time', :with => "19:00"
      click_button "Update Meeting"
      page.should have_content "19:00"
    end
  end
end