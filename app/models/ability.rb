class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.super_admin?
      can :manage, :all
    elsif user.admin?
      can :manage, :all
      cannot :assign_roles, [User]
      cannot :read, [MeetingRole]
    else
      can :read, :all
      can :index, Manual, :id => user.id
      cannot :read, [MeetingRole]
    end
  end

  # def other_user_id(u_id)
  #
  #   other_user_id(user.id)
  #   random_id = rand(0..User.max)
  #   (u_id == random_id) ? other_user_id(u_id) : random_id
  # end
  #
end
