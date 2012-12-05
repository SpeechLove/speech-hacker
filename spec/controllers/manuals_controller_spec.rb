require 'spec_helper'

describe ManualsController do
  let!(:speech) { Fabricate(:speech) }
  let!(:new_manual) { Fabricate(:manual) }

  before(:each) do
   speech.user.add_role(:admin)
   sign_in speech.user
  end

  describe "#index" do
    it "assigns a list of manuals" do
      get(:index, :user_id => speech.user.id)
      assigns(:manuals).should eq Manual.all
    end

    it "assigns the current user to @user if the current user's id equals the passed-in user id" do
      get(:index, :user_id => speech.user.id)
      assigns(:user).should eq speech.user
    end

    it "assigns the user with the passed-in user id to @user" do
      new_user = Fabricate(:user)
      get(:index, :user_id => new_user.id)
      assigns(:user).should eq new_user
    end
  end

  describe "#new" do
    it "creates a new manual" do
      get(:new, :user_id => speech.user.id)
      assigns(:manual).should be_a(Manual)
    end
  end

  describe "#create" do
    it "creates a new manual and increases the manual count by 1" do
      expect {
        post(:create, :user_id => speech.user.id, :manual => { :name => "blah" })
      }.to change(Manual, :count).by(1)
    end
  end

  describe "#edit" do
    it "finds the current manual" do
      get(:edit, :user_id => speech.user.id, :id => new_manual.id )
      assigns(:manual).should be_a(Manual)
      assigns(:manual).id.should eq new_manual.id
      assigns(:manual).should be_valid
    end
  end

  describe "#update" do
    it "updates the manual title" do
      post(:update, :user_id => speech.user.id, :id => new_manual.id, :manual => { :name => new_manual.name } )
      assigns(:manual).name.should eq new_manual.name
    end
  end
end
