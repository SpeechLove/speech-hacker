require 'spec_helper'

describe "MeetingRole", :js => true do
  include Warden::Test::Helpers
  let!(:meeting_role) { Fabricate(:meeting_role )}

  context "when user is not a superadmin" do
    before(:each) do
      @user = Fabricate(:user)
      login_as @user, :scope => :user
    end

    describe "meeting_roles#index" do
      it "shows an error message when attempting to visit the index page" do
        visit meeting_roles_path
        page.should have_content("You are not authorized to access this page.")
      end
    end

    describe "meeting_roles#new" do
      it "shows an error message when attempting to visit the new page" do
        visit new_meeting_role_path
        page.should have_content("You are not authorized to access this page.")
      end
    end

    describe "meeting_roles#edit" do
      it "shows an error message when attempting to visit the edit page" do
        visit edit_meeting_role_path(meeting_role.id)
        page.should have_content("You are not authorized to access this page.")
      end
    end

    describe "meeting_roles#show" do
      it "shows an error message when attempting to visit the show page" do
        visit meeting_role_path(meeting_role.id)
        page.should have_content("You are not authorized to access this page.")
      end
    end
  end

  context "when user is a superadmin" do
    before(:each) do
      @user = Fabricate(:user_superadmin)
      login_as @user
    end

    describe "meeting_roles#index" do
      it "shows the meeting roles index page" do
        visit meeting_roles_path
        page.should have_content("Description")
      end
    end

    describe "meeting_roles#new" do
      it "shows the meeting roles creation page" do
        visit new_meeting_role_path
        page.should have_content("Create New Meeting Role")
      end

      it "has a link called 'Create Meeting role'" do
        visit new_meeting_role_path
        fill_in 'meeting_role_title', :with => meeting_role.title
        fill_in 'meeting_role_description', :with => meeting_role.description
        click_button("Create Meeting role")
        page.should have_content(meeting_role.title)
      end
    end

    describe "meeting_roles#create" do
      it "creates a new role and saves it" do
        visit meeting_roles_path
        page.should have_button("Create New Role")
      end
    end

    describe "meeting_roles#show" do
      it "shows the meeting roles show page" do
        visit meeting_role_path(meeting_role)
        page.should have_content("This is a made-up role!")
      end
    end

    describe "meeting_roles#edit" do
      let!(:toastmaster) { Fabricate(:toastmaster) }

      it "shows the meeting roles edit page" do
        visit edit_meeting_role_path(meeting_role.id)
        page.should have_content(meeting_role.title)
      end

      it "has a link called 'Edit Meeting role'" do
        visit edit_meeting_role_path(meeting_role.id)
        fill_in 'meeting_role_title', :with => toastmaster.title
        fill_in 'meeting_role_description', :with => toastmaster.description
        click_button("Update Meeting role")
        page.should have_content(toastmaster.title)
      end
    end

    describe "meeting_roles#destroy" do
      it "destroys a meeting role" do
        visit meeting_roles_path
        click_link("Destroy")
        page.should have_content("The Meeting Role was destroyed.")
      end
    end
  end

  after{ Warden.test_reset! }
end