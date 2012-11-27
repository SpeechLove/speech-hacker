class Attendance < ActiveRecord::Base
  attr_accessible :meeting_id, :user_id, :meeting_role_id

  belongs_to :meeting
  belongs_to :user
  belongs_to :meeting_role

  validates :meeting_id, :presence => true
  validates :user_id, :presence => true
end
