require 'spec_helper'

describe Meeting do
  subject { Fabricate(:meeting) }

  it { should validate_presence_of :meeting_time }
  it { should validate_format_of(:meeting_time).not_with(/\d{2}\:\d{2}/).with_message("format should be HH:MM") }
  it { should have_many :attendances }
  it { should have_many :users }
  it { should ensure_length_of(:description).is_at_most(255) }

  context "if meeting date is in the wrong format" do
    it "is invalid if the meeting date is empty" do
      meeting = Meeting.new(:meeting_time => "17:00",
                            :location => "conference room")
      meeting.should_not be_valid
    end

    it "is invalid if the format is wrong" do
      meeting = Meeting.new(:meeting_date => "2023-45-12",
                            :meeting_time => "17:00",
                            :location => "conference room")
      meeting.should_not be_valid
    end
  end

  context "#order_by_most_recent_date" do
    it "finds all meetings in descending order by meeting date" do
      meeting_feb = Meeting.create(:meeting_date => "2000-02-03",
                                   :meeting_time => "17:00",
                                   :location => "conference room B")
      meeting_jan = Meeting.create(:meeting_date => "2000-01-12",
                                   :meeting_time => "17:00",
                                   :location => "conference room A")
      meeting_mar = Meeting.create(:meeting_date => "2000-03-20",
                                   :meeting_time => "17:00",
                                   :location => "conference room C")
      Meeting.order_by_most_recent_date.first.should eq meeting_mar
      Meeting.order_by_most_recent_date.last.should  eq meeting_jan
    end
  end
end