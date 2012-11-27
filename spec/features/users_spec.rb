require 'spec_helper'

describe "Users", :js => true do
  include Warden::Test::Helpers

  context "as an admin" do
    before(:each) do
      @user = Fabricate(:user_admin)
      login_as @user, :scope => :user
    end

    it "can view the users" do
      visit users_path
      page.should have_content("biff@example.com")
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
  end
end