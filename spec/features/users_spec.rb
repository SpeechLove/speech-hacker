require 'spec_helper'

describe "Users#index", :js => true do
  include Warden::Test::Helpers

  context "as an admin" do
    before(:each) do
      @user = Fabricate(:user_admin)
      login_as @user, :scope => :user
    end

    it "can view the users" do
      visit users_path
      page.should have_content(@user.email)
    end

    it "can create meetings" do
      visit users_path
      page.should have_link("Create Meeting", :href => new_meeting_path)
    end

    it "can edit the user database" do
      visit users_path
      page.should have_link("Edit Users", :href => users_path)
    end
  end

  context "as a non-admin user" do
    before(:each) do
      @user = Fabricate(:user)
      login_as @user, :scope => :user
    end

    it "cannot view the users" do
      visit users_path
      page.should have_content("You are not authorized to access this page.")
    end

    it "can edit the user's own profile" do
      visit users_path
      click_link 'Edit Profile'
      page.should have_content("Cancel my account.")
    end
  end
end