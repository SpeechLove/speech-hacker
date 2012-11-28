require 'spec_helper'

describe "Meeting", :js => true do
  include Warden::Test::Helpers
  let!(:meeting) { Fabricate(:meeting) }
  before(:each) { visit meetings_path }

  describe "meetings#index" do
    it "shows the meeting date for each meeting" do
      page.should have_link meeting.meeting_date.strftime("%m/%d/%Y")
    end

    it "shows the start time for each meeting" do
      page.should have_content meeting.meeting_time
    end

    it "shows the description for each meeting" do
      page.should have_content meeting.description
    end

    it "shows a blank space if the description is nil" do
      meeting.description = nil
      page.should have_content ""
    end

    it "shows the edit meeting column if user is an admin" do
      @user = Fabricate(:user_admin)
      login_as @user, :scope => :user
      visit meetings_path
      page.should have_link("Edit Meeting", :href => edit_meeting_path(meeting))
    end

    it "hides the edit meeting column if user is not an admin" do
      page.should_not have_link("Edit Meeting", :href => edit_meeting_path(meeting))
    end
  end

  describe "meetings#create" do
    it "displays a form for creating a meeting" do
      # admin needs to be signed in
      visit new_meeting_path
      fill_in 'meeting_meeting_date', :with => meeting.meeting_date
      fill_in 'meeting_meeting_time', :with => meeting.meeting_time
      click_button "Create Meeting"
      page.should have_content meeting.meeting_time
    end
  end

  describe "meetings#edit" do
    it "displays a form for updating a meeting" do
      # admin needs to be signed in
      visit edit_meeting_path(meeting.id)
      fill_in 'meeting_meeting_time', :with => "19:00"
      click_button "Update Meeting"
      page.should have_content "19:00"
    end
  end
end