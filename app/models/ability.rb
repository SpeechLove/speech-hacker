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
      cannot :destroy, [Meeting]
      cannot :read, [MeetingRole]
      cannot :read, User do |this_user|
        this_user.id != user.id
      end
    end
  end
end
