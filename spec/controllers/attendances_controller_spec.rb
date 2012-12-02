require 'spec_helper'

describe AttendancesController do
  let(:absentee_role) { MeetingRole.absentee }
  let(:attendance_params) { { :meeting_role_id => absentee_role.id } }
  let(:user) { Fabricate(:user) }
  let!(:meeting) { Fabricate(:meeting) }

  before(:each) { sign_in user }

  describe "#create" do
    it "assigns a meeting" do
      post(:create, :meeting_id => meeting.id, :attendance => attendance_params)
      assigns(:meeting).should eq(meeting)
    end

    it "creates a new attendance" do
      post(:create, :meeting_id => meeting.id, :attendance => attendance_params)

      assigns(:attendance).meeting_role.title.should eq absentee_role.title

    end
  end

  describe "#update" do
    it "assigns an attendance" do
      attendance = Fabricate(:attendance)
      attendee_role = MeetingRole.attendee
      attendance_params[:meeting_role_id] = attendee_role.id
      put(:update)
      assigns(:attendance).should be_an(Attendance)
    end

  end
end


# attendance attributes :meeting_role_id, :attend, :user, :meeting, :meeting_attributes
