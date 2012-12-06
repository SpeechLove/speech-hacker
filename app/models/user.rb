class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :attendances
  has_many :meetings, :through => :attendances
  has_many :speeches

  validates :name, :presence => true

  def super_admin?
    has_role? :super_admin
  end

  def admin?
    has_role?(:admin)
  end

  def set_admin(make_admin)
    if make_admin && make_admin != "false"
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
    found_attendance = attendance_for_meeting(meeting)
    if(found_attendance)
      return found_attendance.meeting_role
    else
      return MeetingRole.find_by_title('Absentee')
    end
  end

  def attending?(meeting)
    attendance = attendance_for_meeting(meeting)
    (attendance && !attendance.absentee?)
  end

  def attendance_for_meeting(meeting)
    attendances.find_by_meeting_id(meeting.id)
  end

  def meeting_speech(meeting)
    self.speeches.where(:meeting_id => meeting.id).first
  end

  def self.count
    User.all.count
  end

  def speeches_for_manual(manual)
    speeches.for_manual(manual)
  end

end
