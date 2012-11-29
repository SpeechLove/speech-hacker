class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :attendances
  has_many :meetings, :through => :attendances

  validates :name, :presence => true

  def super_admin?
    has_role? :super_admin
  end

  def admin?
    has_role?(:admin)
  end

  def set_admin(make_admin)
    if make_admin
      self.add_role :admin
      true
    else
      self.remove_role :admin
      false
    end
  end

  def responded_to?(meeting)
    meetings.include? meeting
  end

  def meeting_role(meeting)
    attendance_for_meeting(meeting).meeting_role
  end

  def attending?(meeting)
    !attendance_for_meeting(meeting).absentee?
  end

  def attendance_for_meeting(meeting)
    attendances.find_by_meeting_id(meeting.id)
  end
end
