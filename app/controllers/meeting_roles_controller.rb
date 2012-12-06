class MeetingRolesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @meeting_roles = MeetingRole.all_ordered
    @meeting_role  = MeetingRole.new
  end

  def new
    @meeting_role = MeetingRole.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @meeting_roles = MeetingRole.all
    @meeting_role  = MeetingRole.new(params[:meeting_role])

    respond_to do |format|
      if @meeting_role.save
        format.js
      else
        format.js { render "shared/errors", :locals => { :current_object => @meeting_role } }
      end
    end
  end

  def edit
    @meeting_roles = MeetingRole.all
    @meeting_role  = MeetingRole.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def show
    @meeting_role = MeetingRole.find(params[:id])
  end

  def update
    @meeting_roles = MeetingRole.all
    @meeting_role  = MeetingRole.find(params[:id])

    respond_to do |format|
      if @meeting_role.update_attributes(params[:meeting_role])
        format.js
      else
        format.js { render "shared/errors", :locals => { :current_object => @meeting_role } }
      end
    end
  end

  def destroy
    @meeting_roles = MeetingRole.all
    @meeting_role  = MeetingRole.find(params[:id])

    @meeting_role.destroy
    respond_to do |format|
      format.js
    end
  end
end
