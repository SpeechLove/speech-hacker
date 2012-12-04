require 'spec_helper'

describe "Manual", :js => true do
  include Warden::Test::Helpers

  let!(:speech) { Fabricate(:speech) }
  let!(:user) { Fabricate(:user) }
  let!(:user_admin) { Fabricate(:user_admin) }
  let!(:user_superadmin) { Fabricate(:user_superadmin) }
  
  context "when a user is signed in" do
    
    describe "manuals#index" do
      
      it "raises an error when another user accesses any user's manuals index page" do
        login_as user
        visit user_manuals_path(:user_id => speech.user.id)
        puts "speaker #{speech.user.inspect}"
        puts "user #{user.inspect}"
        # debugger
        page.should_not have_content "#{speech.title}"
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
      
      it "lets a super_admin access any user's manuals index page" do
        login_as user_superadmin
        visit user_manuals_path(:user_id => speech.user.id)
        page.should have_content "#{speech.title}"
      end
    end

  end

  after{ Warden.test_reset! }
end