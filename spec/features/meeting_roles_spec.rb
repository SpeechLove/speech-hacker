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
    let(:toastmaster) { Fabricate(:toastmaster)}

    before(:each) do
      @user = Fabricate(:user_superadmin)
      login_as @user
      visit meeting_roles_path
    end

    describe "meeting_roles#index" do
      it "shows the meeting roles index page" do
        page.should have_content("Description")
      end

      it "has a meeting roles creation button" do
        page.should have_button("Create New Role")
      end

      it "has a link called 'Create Meeting role'" do
        click_button("Create New Role")
        page.should have_button("Create Meeting role")
      end

      it "allows the user to create a new role and saves it" do
        click_button("Create New Role")
        fill_in 'meeting_role_title', :with => "Foo"
        fill_in 'meeting_role_description', :with => "Boo"
        click_button("Create Meeting role")
        page.should have_content("Foo")
      end

      it "has a link called 'Edit'" do
        page.should have_link("Edit", :href => edit_meeting_role_path(meeting_role))
      end

      it "updates the meeting role if it is edited" do
        within_table('meeting_roles_table') do
          click_link("Edit")
        end

        fill_in 'meeting_role_title', :with => toastmaster.title
        fill_in 'meeting_role_description', :with => toastmaster.description
        click_button("Update Meeting role")
        page.should have_content(toastmaster.title)
      end

      it "allows the user to destroy a meeting role" do
        click_link("Destroy")
        page.should_not have_content(meeting_role.title)
      end
    end
  end

  after{ Warden.test_reset! }
end