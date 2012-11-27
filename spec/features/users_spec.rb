require 'spec_helper'

describe "Users", :js => true do
  describe "users#index" do
    include Warden::Test::Helpers

    context "when user is an admin" do
      before(:each) do
        @user = Fabricate(:user_admin)
        login_as @user, :scope => :user
      end

      it "has information about each user" do
        visit users_path
        page.should have_content(@user.email)
      end

      it "has a 'Create Meetings' link" do
        visit users_path
        page.should have_link("Create Meeting", :href => new_meeting_path)
      end

      it "has an 'Edit Users' link" do
        visit users_path
        page.should have_link("Edit Users", :href => users_path)
      end
    end

    context "when user is a non-admin user" do
      before(:each) do
        @user = Fabricate(:user)
        login_as @user, :scope => :user
      end

      it "puts up a flash notice forbidding access" do
        visit users_path
        page.should have_content("You are not authorized to access this page.")
      end

      it "has an 'Edit Profile' link" do
        visit users_path
        page.should have_link("Edit Profile", :href => edit_user_registration_path)
        click_link 'Edit Profile'
        page.should have_content("Cancel my account.")
      end
    end
  end
end