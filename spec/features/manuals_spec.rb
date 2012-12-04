require 'spec_helper'

describe "Manual", :js => true do
  include Warden::Test::Helpers

  let!(:speech) { Fabricate(:speech) }
  let!(:user) { Fabricate(:user) }
  let!(:user_admin) { Fabricate(:user_admin) }
  let!(:user_superadmin) { Fabricate(:user_superadmin) }

  context "when a user is signed in" do
    describe "manuals#index" do
      before(:each) do
        login_as user
        visit user_manuals_path(:user_id => user.id)
      end

      it "raises an error when another user accesses any user's manuals index page" do
        visit user_manuals_path(:user_id => speech.user_id)
        page.should have_content("You are not authorized to access this page.")
      end

      it "does not show the edit link" do
        within("div.span9") do
          page.should_not have_link("Edit")
        end
      end

      it "does not show the create button" do
        page.should_not have_button("Create New Manual")
      end
    end

  end

  context "when an admin is signed in" do
    describe "manuals#index" do
      it "lets an admin access any user's manuals index page" do
        login_as user_admin
        visit user_manuals_path(:user_id => speech.user.id)
        page.should have_content "#{speech.title}"
      end
    end

  end

  context "when a super_admin is signed in" do
    describe "manuals#index" do
      before(:each) do
        login_as user_superadmin
        visit user_manuals_path(:user_id => user_superadmin.id)
      end

      it "lets a super_admin access any user's manuals index page" do
        visit user_manuals_path(:user_id => speech.user.id)
        page.should have_content "#{speech.title}"
      end

      it "shows the create button" do
        page.should have_button("Create New Manual")
      end

      it "shows the create form if the create button is clicked" do
        click_button("Create New Manual")
        page.should have_button("Create Manual")
      end

      it "creates the new manual if the create form is submitted" do
        click_button("Create New Manual")
        fill_in 'manual_name', :with => "blah"
        click_button("Create Manual")
        page.should have_content("blah")
      end

      it "shows the edit link" do
        within("div.span9") do
          page.should have_link("Edit")
        end
      end

      it "hides the create button when the edit link is clicked" do
        within("div.span9") do
          click_link("Edit")
        end
        page.should have_selector("#new_manual_button", :visible => false)
      end

      it "shows the update manual form when the edit link is clicked" do
        within("div.span9") do
          click_link("Edit")
        end
        page.should have_button("Update Manual")
      end

      it "updates the manual name when the update form is submitted" do
        within("div.span9") do
          click_link("Edit")
        end
        fill_in 'manual_name', :with => "blah"
        click_button("Update Manual")
        page.should have_content("blah")
      end
    end
  end

  after{ Warden.test_reset! }
end