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
      cannot :read, [User]
      cannot :read, [MeetingRole]
    end
  end
end
