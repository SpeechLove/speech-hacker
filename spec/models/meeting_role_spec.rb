require 'spec_helper'

describe MeetingRole do
  subject { Fabricate(:meeting_role) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :description }

  it { should validate_uniqueness_of :title }

  describe "absentee" do
    it "should return an absentee role" do
      MeetingRole.absentee.title.should eq "Absentee"
    end
  end

  describe "attendee" do
    it "should return an attendee role" do
      MeetingRole.attendee.title.should eq "Attendee"
    end
  end

  describe "absentee?" do
    it "should evaluate whether or not the role is Absentee" do
      Fabricate(:meeting_role).absentee?.should be_false
    end
  end

end