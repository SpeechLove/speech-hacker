class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!
  before_filter :admin_only, :only => [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # authorize! :assign_roles, current_user if assigning_roles?
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def make_admin
    logger.info("------------ make admin ----------------")
    should_be_admin = false
    logger.info("these are params: #{params.inspect}")

    @user = User.find(params[:id])
    if params[:make_admin]
      @user.add_role :admin
      should_be_admin = true
    else
      @user.remove_role :admin
    end

    respond_to do |format|
      format.json do
        if should_be_admin == @user.has_role?(:admin)
          logger.info("success")
          render :json => {
                            :success => true
                            #:user  => render_to_string(
                            #              :locals => {:user => @user})
                          }
        else
          logger.info("error")
          render :json => {
                            :errors => @user.errors.full_messages.join(', '),
                            :status => :unprocessable_entity
                          }
        end
      end
    # render :index
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
