require 'spec_helper'

describe "Attendances", :js => true do
  include Warden::Test::Helpers

  describe "meetings#show" do
    context "when meeting hasn't occurred" do
      let!(:meeting) { Fabricate(:meeting, :meeting_date => "12/12/2050") }

      context "Attendance form" do
        it "shows the sign up header" do
          @user = Fabricate(:user)
          login_as @user, :scope => :user
          visit meeting_path meeting
          page.should have_content "Sign-up"
        end

        it "allows user to confirm attendance with no role" do
          Fabricate(:attendee)
          @user = Fabricate(:user)
          login_as @user, :scope => :user
          visit meeting_path meeting
          find(:css, "#attendance_attend_true").set(true)
          click_button "Create Attendance"
          page.should have_content("See you there!")
        end

        it "allows user to decline to attend" do
          Fabricate(:absentee)
          @user = Fabricate(:user)
          login_as @user, :scope => :user
          visit meeting_path meeting
          find(:css, "#attendance_attend_false").set(true)
          click_button "Create Attendance"
          page.should have_content("Sorry you're not coming.")
        end

        it "allows user to confirm attendance with a role" do
          Fabricate(:toastmaster)
          @user = Fabricate(:user)
          login_as @user, :scope => :user
          visit meeting_path meeting
          find(:css, "#attendance_attend_true").set(true)
          find(:css, "#attendance_meeting_role_id_1").set(true)
          click_button "Create Attendance"
          page.should have_content("See you there!")
        end
      end
    end
  end
end