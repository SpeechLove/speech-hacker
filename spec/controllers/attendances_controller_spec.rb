require 'spec_helper'

describe AttendancesController do
  let(:absentee_role) { MeetingRole.absentee }
  let(:attendance_params) { { :meeting_role_id => absentee_role.id } }
  let!(:user) { Fabricate(:user) }
  let!(:meeting) { Fabricate(:meeting) }
  let!(:toastmaster) {Fabricate(:toastmaster)}

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

    it "sends an alert if an invalid attendance is created" do
      post(:create, :meeting_id => meeting.id, :attendance => attendance_params)
      assigns(:meeting_roles).should eq MeetingRole.attendee_roles
    end
  end

  describe "#update" do
    it "assigns an attendance" do
      sign_in user
      attendance = Attendance.create(:attend => "true",
                                  :user => user,
                                  :meeting=> meeting,
                                  :meeting_role => Fabricate(:grammarian),
                                  :meeting_role_id => 2)
      attendee_role = MeetingRole.attendee
      attendance_params[:meeting_role_id] = attendee_role.id
      put(:update, :id => attendance.id,
          :attendance => {:attend => "true",
                          :meeting_role_id => attendee_role.id,
                          :meeting_role => attendee_role}
          )
      assigns(:attendance).should be_an(Attendance)
    end

  end
end


# attendance attributes :meeting_role_id, :attend, :user, :meeting, :meeting_attributes
