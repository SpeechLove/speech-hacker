class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

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

  def attending?(meeting)
    if meeting.attendances[0] != nil
      logger.info("----------------------does meeting attendances user id = self.id?------------------------")
      logger.info(meeting.attendances[0].user_id == self.id)
      logger.info(meeting.attendances[1].inspect)
      logger.info(meeting.attendances[0].user_id)
      logger.info(self.id)
      return meeting.attendances[0].user_id == self.id && meeting_role(meeting).title != "Absentee"
    else
      return false
    end
  end

  def meeting_role(meeting)
    MeetingRole.find(meeting.attendances[0].meeting_role_id)
  end
end