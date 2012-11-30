require 'spec_helper'

describe MeetingRolesController do
  let!(:meeting_role) { Fabricate(:meeting_role) }
  before(:each) { sign_in Fabricate(:user_superadmin) }

  describe "#index" do
    it "assigns a list of meeting roles" do
      get(:index)
      assigns(:meeting_roles).should eq [meeting_role]
    end
  end

  describe "#new" do
    it "assigns a new meeting role" do
      get(:new)
      assigns(:meeting_role).should be_a(MeetingRole)
    end
  end

  describe "#create" do
    it "creates a new meeting role object" do
      post(:create, :meeting_role => {:title => meeting_role.title, :description => meeting_role.description})
      assigns(:meeting_role).title.should eq meeting_role.title
      assigns(:meeting_role).should be_valid
    end
  end

  describe "#show" do
    it "shows the meeting role info" do
      get(:show, :id => meeting_role.id)
      assigns(:meeting_role).should eq meeting_role
    end
  end

  describe '#edit' do
    it "assigns a meeting role" do
      get(:edit, :id => meeting_role.id)
      assigns(:meeting_role).should be_a(MeetingRole)
    end
  end
end