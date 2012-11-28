class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!
  before_filter :admin_only, :only => [:index]

  def index
    @users = User.all
  end

  def edit

  end

  def update
    authorize! :assign_roles, @user if assigning_roles?
  end

  private

  def admin_only
    redirect_to root_path, notice: "You are not authorized to access this page." unless current_user.admin?
  end

  def assigning_roles?
    params[:user].has_key?(:roles)
  end
end
