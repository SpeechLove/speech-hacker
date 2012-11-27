class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only, :only => [:index]

  def index
    @users = User.all
  end

  def edit

  end

  private

  def admin_only
    redirect_to root_path unless current_user.admin?
  end
end