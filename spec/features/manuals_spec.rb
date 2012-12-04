require 'spec_helper'

describe "Manuals", :js => true do
  include Warden::Test::Helpers

  context "when user is not a superadmin" do
    before(:each) do
      @user = Fabricate(:user)
      login_as @user, :scope => :user
      visit user_manuals_path(@user)
    end

    describe "manuals#index" do
      it "shows the manuals index page" do
        page.should have_content("My Progress")
      end

      it "does not show the edit link" do
        within("div.span9") do
          page.should_not have_link("Edit")
        end
      end

      it "does not show the create form" do
        page.should_not have_button("Create Manual")
      end
    end
  end

  context "when user is a superadmin" do
    before(:each) do
      @user = Fabricate(:superadmin)
      login_as @user, :scope => :user
      visit user_manuals_path(@user)
    end

    describe "manuals#index" do
      it "shows the edit link" do
        within("div.span9") do
          page.should have_link("Edit")
        end
      end

      it "shows the create form" do
        page.should have_button("Create Manual")
      end
    end
  end

  after{ Warden.test_reset! }
end
