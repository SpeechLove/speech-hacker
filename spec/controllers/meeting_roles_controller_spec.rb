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
      post(:create, :meeting_role => {:title => "Youngmaster Junior", :description => "super fly"})
      assigns(:meeting_role).title.should eq "Youngmaster Junior"
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

  describe '#update' do
    it "updates a meeting role object" do
      put(:update, :id => meeting_role.id, :meeting_role => {:title => "YoungMaster", :description => "Master of the Universe"})
      assigns(:meeting_role).should be_a(MeetingRole)
      assigns(:meeting_role).title.should eq "YoungMaster"
    end
  end

  describe '#destroy' do
    it "destroys a meeting role object" do
      id_num = meeting_role.id
      delete(:destroy, :id => meeting_role.id)
      expect{ MeetingRole.find(id_num) }.to raise_error
    end
  end
end