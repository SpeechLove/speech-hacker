class MeetingRolesController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!
  before_filter :superadmin_only

  def index
    @meeting_roles = MeetingRole.all
    @meeting_role = MeetingRole.new
  end

  def new
    @meeting_role = MeetingRole.new

    respond_to do |format|
      format.html { redirect_to meeting_roles_path }
      format.js
    end
  end

  def create
    @meeting_roles = MeetingRole.all
    @meeting_role = MeetingRole.new(params[:meeting_role])
    respond_to do |format|
      if @meeting_role.save
          format.html { redirect_to meeting_roles_path, :notice => "Meeting role was successfully created." }
          format.js { render 'create.js.erb', :locals => { :meeting_role_id => @meeting_role.id,
                                                           :meeting_role_title => @meeting_role.title,
                                                           :meeting_role_description => @meeting_role.description }}
      else
        render 'index', alert: "Meeting could not be created."
      end
    end
  end

  def edit
    @meeting_roles = MeetingRole.all
    @meeting_role = MeetingRole.find(params[:id])
    respond_to do |format|
      format.html
      format.js { render 'edit.js.erb', :locals => { :meeting_role_title => @meeting_role.title }}
    end
  end

  def show
    @meeting_role = MeetingRole.find(params[:id])
  end

  def update
    @meeting_roles = MeetingRole.all
    @meeting_role = MeetingRole.find(params[:id])

    respond_to do |format|
      format.html { redirect_to @meeting_role, :notice => "The Meeting role is updated." }
      format.js { render 'update.js.erb', :locals => { :meeting_role_title => @meeting_role.title,
                                                       :meeting_role_description => @meeting_role.description,
                                                       :meeting_role_params => params[:meeting_role] }}
    end

    @meeting_role.update_attributes(params[:meeting_role])
  end

  def destroy
    @meeting_roles = MeetingRole.all
    @meeting_role = MeetingRole.find(params[:id])
    respond_to do |format|
      if @meeting_role.destroy
        format.html { redirect_to meeting_roles_path, :notice => "The Meeting Role was destroyed." }
        format.js { render 'destroy.js.erb', :locals => { :meeting_role_title => @meeting_role.title }}
      else
        render 'index', alert: "The Meeting Role stubbornly refused to be destroyed. Please try again."
      end
    end
  end

  private
  def superadmin_only
    current_user.super_admin?
  end
end
