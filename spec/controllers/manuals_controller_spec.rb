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
      get(:index)
      assigns(:manuals).should eq Manual.all
    end
  end

  describe "#new" do
    it "creates a new manual" do
      get(:new)
      assigns(:manual).should be_a(Manual)
    end
  end

  describe "#create" do
    it "creates a new manual and increases the manual count by 1" do
      expect {
        post(:create, :manual => { :name => "blah" })
      }.to change(Manual, :count).by(1)
    end
  end

  describe "#edit" do
    it "finds the current manual" do
      get(:edit, :id => new_manual.id )
      assigns(:manual).should be_a(Manual)
      assigns(:manual).id.should eq new_manual.id
      assigns(:manual).should be_valid
    end
  end

  describe "#update" do
    it "updates the manual title" do
      post(:update, :id => new_manual.id, :manual => { :name => new_manual.name } )
      assigns(:manual).name.should eq new_manual.name
    end
  end
end
