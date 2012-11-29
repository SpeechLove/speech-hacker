class MeetingRole < ActiveRecord::Base
  attr_accessible :title, :null => false, :unique => true

  scope :attendee_roles, where("title != 'Absentee'")

  def self.absentee
    find_or_create_by_title("Absentee")
  end

  def self.attendee
    find_or_create_by_title("Attendee")
  end

  def absentee?
    title == "Absentee"
  end
end
