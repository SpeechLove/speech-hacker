class Meeting < ActiveRecord::Base
  attr_accessible :meeting_date, :meeting_time

  has_many :attendances

  validates :meeting_date, :presence => true
  validates :meeting_time, :presence => true
end
