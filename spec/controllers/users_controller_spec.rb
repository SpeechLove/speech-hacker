require 'spec_helper'

describe UsersController do
  let!(:user) { Fabricate(:user) }
  let!(:user_admin) { Fabricate(:user_admin) }
  let!(:user_superadmin) { Fabricate(:user_superadmin) }

  describe "#index" do
    context "when the current user is admin" do
      it "assigns a list of users" do
        sign_in user_admin
        get(:index)
        assigns(:users).should eq [user, user_admin, user_superadmin]
      end
    end

    context "when the current user is not admin" do
      it "redirects to root" do
        sign_in user
        get(:index)
        response.should redirect_to root_path
      end
    end
  end

  describe "#show" do
    let!(:other_user) { Fabricate(:user) }
    
    context "when a user tries to access another user's records" do
      context "when the current user is admin" do
        it "shows information about a user" do
          sign_in user_admin
          get(:show, :id => other_user.id)
          assigns(:user).id.should eq(other_user.id)
        end
      end

      context "when the current user is not admin" do
        it "does not allow the user to see records" do
          sign_in user
          get(:show, :id => other_user.id)
          response.should redirect_to root_path
        end
      end
    end

    context "When users access their own records" do
      it "shows information about the current user" do
        sign_in user
        get(:show, :id => user.id)
        assigns(:user).id.should eq(user.id)
      end
    end
  end

  describe "#edit" do
    context "when the current user is admin" do
      it "shows information about a user" do
        sign_in user_admin
        get(:edit, :id => 1)
        assigns(:user).should be_a(User)
      end
    end

    context "when the current user is not admin" do
      it "does not show information about a user" do
        sign_in user
        get(:edit, :id => 1)
        response.should redirect_to root_path
      end
    end
  end

  describe "#update" do
    context "when the current user is admin" do
      it "shows information about a user" do
        sign_in user_admin
        put(:update, :id => 1, :user => {:name => "John Newname",
                                         :email => "new@new.com"})
        assigns(:user).should be_a(User)
        assigns(:user).name.should eq "John Newname"
        assigns(:user).email.should eq "new@new.com"
      end
    end

    context "when the current user is not admin" do
      it "does not show information about a user" do
        sign_in user
        post(:update, :id => 1)
        response.should redirect_to root_path
      end
    end
  end

  describe '#destroy' do
    it "destroys the user object" do
      sign_in user_superadmin
      delete(:destroy, :id => 1)
      User.all.length.should eq 2
    end
  end

  describe "#make_admin" do
    context "when the current user is super admin" do
      it "shows information about a user" do
        sign_in user_superadmin
        get(:make_admin, :id => 1)
        assigns(:user).should be_a(User)
      end
    end

    context "when the current user is admin" do
      it "does not show information about a user" do
        sign_in user_admin
        get(:make_admin, :id => 1)
        response.should redirect_to root_path
      end
    end

    context "when the current user is not admin" do
      it "does not show information about a user" do
        sign_in user
        get(:make_admin, :id => 1)
        response.should redirect_to root_path
      end
    end
  end

end