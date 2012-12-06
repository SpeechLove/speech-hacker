require 'spec_helper'

describe "Navigation", :js => true do
  include Warden::Test::Helpers

  context "when nobody is logged in" do
    before(:each) { visit meetings_path }

    it "shows a sign in bar" do
      page.should have_link("Sign In", :href => new_user_session_path)
      click_link "Sign In"
      page.should have_content("Remember me")
    end

    it "does not show Current Meetings in bar" do
      page.should_not have_link("Current Meetings")
    end

    it "does not have the Create Meeting in the navigation bar" do
      page.should_not have_link("Create Meeting", :href => new_meeting_path)
    end

  end

  context "when member is logged in" do
    before(:each) do
      @user = Fabricate(:user)
      login_as @user, :scope => :user
      visit meetings_path
    end

    it "shows Current Meetings in bar" do
      page.should have_link("Current Meetings", :href => meetings_path)
    end

    it "has a link with the member's name on it" do
      within('#user-menu') do
        page.should have_link "#{@user.name}"
      end
    end

    it "shows My Progress in the dropdown menu" do
      click_link "#{@user.name}"
      click_link "My Progress"
      page.should have_content("Progress for #{@user.name}")
    end

    it "shows Edit Profile in dropdown menu" do
      click_link "#{@user.name}"
      click_link "Edit Profile"
      page.should have_content("Cancel my account")
    end

    it "shows Sign Out on menu" do
      click_link "#{@user.name}"
      click_link "Sign Out"
      page.should have_content("Signed out successfully.")
    end

    it "does not have the Create Meeting in the navigation bar" do
      page.should_not have_link("Create Meeting", :href => new_meeting_path)
    end

  end

  context "when admin is logged in" do
    before(:each) do
      @user = Fabricate(:user_admin)
      login_as @user, :scope => :user
      visit meetings_path
    end

    it "shows Create Meeting in navigation bar" do
      page.should have_link("Create Meeting", :href => new_meeting_path)
      click_link "Create Meeting"
      page.should have_content("Meeting date")
    end


    it "shows Members in navigation bar" do
      click_link "Manage"
      page.should have_link("Members", :href => users_path)
      click_link "Members"
      page.should have_content("Member Name")
    end

    it "does not have the Meeting Roles on the navigation bar" do
      page.should_not have_link("Meeting Roles", :href => meeting_roles_path)
    end
  end

  context "when superadmin is logged in" do
    before(:each) do
      @user = Fabricate(:user_superadmin)
      login_as @user, :scope => :user
      visit meetings_path
    end

    it "shows Meeting Roles on the navigation bar" do
      click_link "Manage" 
      page.should have_link("Meeting Roles", :href => meeting_roles_path)
      click_link "Meeting Roles"
      page.should have_button("Create New Role")
    end
  end

  after{ Warden.test_reset! }
end
