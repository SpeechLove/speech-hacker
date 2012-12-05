require 'spec_helper'

describe "Users", :js => true do
  include Warden::Test::Helpers

  context "when user is a non-admin user" do
    before(:each) do
      @user = Fabricate(:user)
      login_as @user, :scope => :user
    end

    describe "users#index" do
      it "puts up a flash notice forbidding access" do
        visit users_path
        page.should have_content("You are not authorized to access this page.")
      end

#       it "has a 'My Speeches' link" do
#         visit users_path
#         page.should have_link("My Speeches", :href => speeches_path)
#       end

      it "has an 'Edit Profile' link" do
        visit users_path
        page.should have_link("Edit Profile", :href => edit_user_registration_path)
      end
      #link was removed need to check at merge
      it "has an 'Edit Profile' link" do
        pending
        visit users_path
        page.should have_link("My Progress", :href => user_progress_path(@user))
      end
    end
  end

  context "when user is an admin" do
    before(:each) do
      @user = Fabricate(:user_admin)
      login_as @user, :scope => :user
    end

    describe "users#index" do
      before(:each) { visit users_path }
      it "has information about each user" do
        page.should have_content(@user.email)
      end

      it "has a 'Create Meetings' link" do
        page.should have_link("Create Meeting", :href => new_meeting_path)
      end

      it "has an 'Edit Users' link" do
        page.should have_link("Members", :href => users_path)
      end

      it "should not have the Make Admin column" do
        page.should_not have_content("Make admin?")
      end
    end
  end

  context "when user is a superadmin" do
    before(:each) do
      @user = Fabricate(:user_superadmin)
      login_as @user, :scope => :user
    end

    describe "users#index" do
      it "does not have a make admin checkbox column if only the superadmin is present" do
        visit users_path
        page.should have_content("Make admin?")
        page.should_not have_css('.make-admin-option')
      end

      it "has a make admin checkbox column if other users are present" do
        Fabricate(:user_admin)
        visit users_path
        page.should have_content("Make admin?")
        page.should have_css('.make-admin-option')
      end
    end
  end
  after{ Warden.test_reset! }

end