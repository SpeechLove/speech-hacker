require 'spec_helper'

describe MeetingsController do
  let!(:user) {Fabricate(:user)}
  let!(:project) { Fabricate(:project) }
  let!(:meeting) { Fabricate(:meeting)}
  let!(:speech) { Fabricate(:speech, :user_id => user.id, 
                            :meeting => meeting, 
                            :project_id => project.id) }

  describe "#index" do
    it "assigns a list of users" do
      get(:index)
      assigns(:meetings).should eq [meeting]
    end
  end

  describe "#new" do
    it "creates a new meeting" do
      get(:new)
      assigns(:meeting).should be_a(Meeting)
    end
  end

  describe "#create" do
    it "creates a new meeting and saves it to the database" do
      post(:create, :id => meeting.id)
      assigns(:meeting).should be_a(Meeting)
      assigns(:meeting).should be_valid
    end
  end

  describe '#show' do
    it "assigns meeting with the current meeting" do
      get(:show, :id => meeting.id)
      assigns(:meeting).should be_a(Meeting)
      assigns(:meeting).should be_valid
    end
  end

  describe '#destroy' do
    it "destroys the meeting object" do
      delete(:destroy, :id => meeting.id)
      Meeting.all.length.should eq 0
    end
  end

  describe '#edit' do
    it "assigns meeting with the current meeting" do
      get(:edit, :id => meeting.id)
      assigns(:meeting).should be_a(Meeting)
      assigns(:meeting).should be_valid
    end
  end

  describe '#update' do
    it "updates the meeting" do
      put(:update, :id => meeting.id, :meeting => {:meeting_date => "1988-11-22", :meeting_time => "05:00"})
      assigns(:meeting).should be_a(Meeting)
      assigns(:meeting).meeting_date.to_s.should eq "1988-11-22"
    end
  end
end
