require 'spec_helper'

describe Attendance do
  subject(:attendance) { Fabricate(:attendance) }

  it { should validate_presence_of :meeting }
  it { should validate_presence_of :user }
  it { should validate_presence_of :meeting_role_id }
  it { should validate_uniqueness_of(:user_id).scoped_to(:meeting_id) }

  [:meeting, :user, :meeting_role].each do |object|
    it { should belong_to object }
  end

  context "Methods" do
    let(:non_attendance) { Fabricate(:non_attendance) }

    describe "attend" do
      #let(:non_attendance) { Fabricate(:non_attendance) }

      it "returns the attend value for an attendance" do
        subject.attend.should be_true
        non_attendance.attend.should be_false
      end

    end

    describe "attend?" do
      it "returns returns the value of attend" do
        subject.attend?.should eq subject.attend
        non_attendance.attend?.should eq non_attendance.attend
      end

    end

    describe "assign_meeting_role" do
      it "assigns a meeting_role of Attendee to a new attendance" do
        new_attendance = Attendance.new(:attend => "true")
        new_attendance.assign_meeting_role
        new_attendance.meeting_role.title.should eq "Attendee"
      end

      it "updates an attendance's meeting_role from Absentee to Attendee if attend is true" do
        non_attendance.assign_meeting_role
        non_attendance.meeting_role.title.should eq "Attendee"

      end

      it "assigns a meeting_role of absentee if attend is false" do
        subject.assign_meeting_role
        subject.meeting_role.title.should eq "Absentee"
      end

    end

  end

end
