class Attendance < ActiveRecord::Base
  attr_accessible :meeting_role_id, :attend, :user, :meeting, :meeting_attributes, :meeting_role
  attr_accessor :attend

  belongs_to :meeting
  belongs_to :user
  belongs_to :meeting_role

  validates :meeting, :presence => true
  validates :user, :presence => true
  validates :meeting_role_id, :presence => true
  validates :user_id, :uniqueness => { :scope => :meeting_id }
  before_validation :assign_meeting_role

  delegate :absentee?, :to => :meeting_role
  accepts_nested_attributes_for :meeting

  def assign_meeting_role
    if attend == true && (meeting_role == MeetingRole.absentee || meeting_role.nil?)
      self.meeting_role = MeetingRole.attendee
    elsif attend == false
      self.meeting_role = MeetingRole.absentee
    end
  end

  def attend
    if @attend == "true"
      true
    else
      meeting_role != MeetingRole.absentee && @attend == "true"
    end
  end

  def attend?
    attend
  end
end