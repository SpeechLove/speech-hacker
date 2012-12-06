require 'spec_helper'

describe "Meeting", :js => true do
  include Warden::Test::Helpers

  let!(:meeting) { Fabricate(:meeting) }

  context "when user is not an admin" do
    let!(:user) { Fabricate(:user)}
    before(:each) { 
      login_as user, :scope => :user
    } 

    describe "meetings#index" do
      it "shows the meeting date for each meeting" do
        visit meetings_path
        page.should have_link meeting.formatted_full_date
      end

      it "shows the start time for each meeting" do
        visit meetings_path
        page.should have_content meeting.meeting_time
      end

      it "shows a blank space if the description is nil" do
        visit meetings_path
        meeting.description = nil
        page.should have_content ""
      end

      it "hides the edit meeting column" do
        visit meetings_path    
        page.should_not have_link("Edit", :href => edit_meeting_path(meeting))
      end

      it "hides the cancel meeting column" do
        visit meetings_path
        page.should_not have_button("Cancel")
      end

      it "has a button to sign up for a role if the meeting is in the future" do
        meeting_future = Meeting.create(  :meeting_date => (Date.today + 5),
                                          :meeting_time => "12:00",
                                          :location => "Singapore")
        visit meetings_path
         page.should have_button("Sign up for a role")
      end

      it "has view agenda button if the meeting is in the past" do
        Meeting.create( :meeting_date => (Date.today - 5),
                        :meeting_time => "12:00",
                        :location => "Singapore")
        visit meetings_path
        page.should have_button("View agenda")
      end
    end
  end

  context "when user is an admin" do
    let!(:user_admin){Fabricate(:user_admin)}
    before(:each) do
      login_as user_admin, :scope => :user
    end

    describe "meetings#index" do
      it "shows the edit meeting column" do
        visit meetings_path
        page.should have_link("Edit", :href => edit_meeting_path(meeting))
      end

      it "shows the cancel meeting column" do
        visit meetings_path
        page.should have_button("Cancel")
      end

      it "destroys the meeting if the user clicks on 'Cancel'" do
        visit meetings_path
        click_button("Cancel")

        # A confirmation box is expected, so accept the warning.
        page.driver.browser.switch_to.alert.accept
        page.should_not have_content(meeting.description)
      end

      it "has a button to sign up for a role if the meeting is in the future" do
        meeting_future = Meeting.create(  :meeting_date => (Date.today + 5),
                                          :meeting_time => "12:00",
                                          :location => "Singapore")
        visit meetings_path
         page.should have_button("Sign up for a role")
      end

      it "has view agenda button if the meeting is in the past" do
        Meeting.create( :meeting_date => (Date.today - 5),
                        :meeting_time => "12:00",
                        :location => "Singapore")
        visit meetings_path
        page.should have_button("View agenda")
      end
    end

    describe "meetings#show" do
      it "shows the description for a meeting in show" do
        visit meeting_path(meeting)
        page.should have_content meeting.description
      end
    end

    describe "meetings#create" do
      it "displays a form for creating a meeting" do
        visit new_meeting_path
        fill_in 'meeting_meeting_date', :with => meeting.meeting_date
        fill_in 'meeting_meeting_time', :with => meeting.meeting_time
        fill_in 'meeting_location', :with => meeting.location
        click_button "Create Meeting"
        page.should have_content meeting.meeting_time
      end

      it "raises an error if a user tries to create a meeting with invalid info" do
        visit new_meeting_path
        #fill_in 'meeting_meeting_time', :with => ""
        click_button "Create Meeting"
        page.should have_content "Meeting date format should be YYYY-MM-DD"
      end
    end

    describe "meetings#edit" do
      it "displays a form for updating a meeting" do
        visit edit_meeting_path(meeting.id)
        fill_in 'meeting_meeting_time', :with => "19:00"
        click_button "Update Meeting"
        page.should have_content "19:00"
      end

      it "raises an error if a user tries to update a meeting with invalid info" do
        visit edit_meeting_path(meeting.id)
        fill_in 'meeting_meeting_time', :with => ""
        click_button "Update Meeting"
        page.should have_content "Meeting time can't be blank"
      end
    end
  end

  after{ Warden.test_reset! }
end
