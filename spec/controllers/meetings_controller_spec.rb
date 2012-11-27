require 'spec_helper'

describe MeetingsController do
  let!(:meeting) { Fabricate(:meeting) }

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
      post(:create, :meeting => {:meeting_date => meeting.meeting_date, :meeting_time => meeting.meeting_time})
      assigns(:meeting).should be_a(Meeting)
      assigns(:meeting).should be_valid
    end
  end

  describe '#show' do
    it "assigns meeting with the current meeting" do
      get(:show, :id => 1)
      assigns(:meeting).should be_a(Meeting)
      assigns(:meeting).should be_valid
    end
  end

  describe '#destroy' do
    it "destroys the meeting object" do
      # delete(:destroy, :id => 1)
    end
  end
end
