require 'spec_helper'


describe UsersController do
  describe "#index" do
    context "when the current user is admin" do
      it "assigns a list of users" do
        user = Fabricate(:user_admin)
        sign_in user
        get(:index)
        assigns(:users).should eq [user]
      end
    end

    context "when the current user is not admin" do
      it "redirects to root" do
        user = Fabricate(:user)
        sign_in user
        get(:index)
        response.should redirect_to root_path
      end
    end
  end
end