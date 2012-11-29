class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

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
      role = MeetingRole.find(meeting.attendances[0].meeting_role_id)
      return meeting.attendances[0].user_id == self.id && role.title != "Absentee"
    else
      return false
    end
  end
end
