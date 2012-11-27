class Meeting < ActiveRecord::Base
  attr_accessible :meeting_date, :meeting_time

  has_many :attendances
end
