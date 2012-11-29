class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!
  before_filter :admin_only, :only => [:index]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def progress
    @user = User.find(params[:id])
    @completed = completed_projects(@user.id)
    @manuals = Manual.find(@completed.keys)
    @manuals = [@manuals] if @manuals.class == Manual
    respond_to do |format|
      format.html
    end
  end

  def completed_projects(u_id)
    speeches = Speech.where({:user_id => u_id })
    speeches = [speeches] if (speeches.class == Speech)
    speech_ids = speeches.collect{ |s| s.id }
    project_ids = speeches.collect{ |s| s.project_id }
    projects = Project.find(project_ids)
    completed = Hash.new

    projects.each do |p|
      completed[p] = speeches.find{ |s| s.project_id == p.id }
    end

    completed.group_by{ |pair| pair[0].manual_id }
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  def make_admin
    authorize! :assign_roles, current_user
    @user = User.find(params[:id])
    should_be_admin = @user.set_admin(params[:make_admin])

    respond_to do |format|
      format.json do
        if should_be_admin == @user.has_role?(:admin)
          render :json => { :success => true }
        else
          render :json => {
                            :errors => @user.errors.full_messages.join(', '),
                            :status => :unprocessable_entity
                          }
        end
      end
    end
  end

  private

  def admin_only
    unless current_user.admin? or current_user.super_admin?
      redirect_to root_path, notice: "You are not authorized to access this page."
    end
  end

  def assigning_roles?
    params[:user].has_key?(:roles)
  end

end
