class MeetingRolesController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!
  before_filter :superadmin_only

  def index
    @meeting_roles = MeetingRole.all
  end

  def new
    @meeting_role = MeetingRole.new
  end

  def create
    @meeting_role = MeetingRole.new(params[:meeting_role])

    if @meeting_role.save
      redirect_to @meeting_role, :notice => "Meeting role was successfully created."
    else
      render 'new', alert: "Meeting could not be created."
    end
  end

  def edit
    @meeting_role = MeetingRole.find(params[:id])
  end

  def show
    @meeting_role = MeetingRole.find(params[:id])
  end

  def update

  end

  def destroy

  end

  private
  def superadmin_only
    current_user.super_admin?
  end
end
