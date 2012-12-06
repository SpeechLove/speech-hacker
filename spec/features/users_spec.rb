require 'spec_helper'

describe "Users", :js => true do
  include Warden::Test::Helpers

  context "when user is a user" do
    describe "users#index" do
      let!(:user) {Fabricate(:user)}
      let!(:user2) {Fabricate(:user)}

      before(:each) do
        login_as user, :scope => :user
      end

      it "puts up a flash notice forbidding access" do
        visit users_path
        page.should have_content("You are not authorized to access this page.")
      end

      it "forbids them from accessing another user's page " do
        visit user_path(user2)
        page.should have_content("You are not authorized to access this page.")
      end


      it "has an 'Edit Profile' link" do
        visit users_path
        page.should have_link("Edit Profile", :href => edit_user_registration_path)
      end
    end

    describe "users#show" do
      let!(:speech) { Fabricate(:speech) }
      before(:each) do
        login_as speech.user
        visit user_path(speech.user)
      end
      it "has the title Progress for current_user" do
        page.should have_content("Progress for #{speech.user.name}")
      end

      it "should have a button that let's the user see all of their speeches" do
        page.should have_button("All Speeches")
        click_button("All Speeches")
        page.should have_content("Speeches by #{speech.user.name}")
      end

      it "should display the progress of the user" do
        manual = Manual.all
        projects = manual[0].projects.all
        page.should have_content("#{speech.project.manual.name.ljust(40)} (1/#{projects.count})")
      end

      it "should have a specific user's speeches" do
        click_link "#{speech.project.manual.name}"
        page.should have_content "#{speech.title}"
      end
    end
  end

  context "when user is an admin" do
    let!(:user1) {Fabricate(:user)}
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

      it "has an 'Members' link" do
        page.should have_link("Members", :href => users_path)
      end

      it "should not have the Make Admin column" do
        page.should_not have_content("Make admin?")
      end

      it "should display links for all users" do
        page.should have_link(user1.name)
      end

      it "links to a specific user's show page" do
        click_link(user1.name)
        page.should have_content("Progress for #{user1.name}")
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