require 'spec_helper'

describe "Meetings", :js => true do
  describe "view meetings" do
    let!(:meeting) { Fabricate(:meeting,
                                meeting_date: "11/12/2012",
                                meeting_time: "18:00") }

    it "shows meeting date and time for each meeting" do
      visit meetings_path
      page.should have_link("11/12/2012")
      page.should have_content("18:00")
    end
  end

  describe "create and edit meetings" do
    let!(:meeting) { Fabricate(:meeting,
                                meeting_date: "11/12/2012",
                                meeting_time: "18:00") }

    it "creates a meeting" do
      # admin needs to be signed in
      visit new_meeting_path
      fill_in('meeting_meeting_date', :with => "11/12/2012")
      fill_in('meeting_meeting_time', :with => "18:00")
      click_on("Create Meeting")
      page.should have_content("18:00")
    end

    it "edits a meeting" do
      # admin needs to be signed in
      visit edit_meeting_path(meeting.id)
      fill_in('meeting_meeting_time', :with => "19:00")
      click_on("Update Meeting")
      page.should have_content("19:00")
    end
  end
end