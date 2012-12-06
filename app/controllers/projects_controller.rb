class ProjectsController < ApplicationController
  def index
    @manual = Manual.find(params[:manual_id])
    @user = current_user

    respond_to do |format|
      format.json { render :partial => 'projects/projects', :locals => { :manual => @manual } }
    end
  end

  def projects_by_manual
    @projects = Project.find_all_by_manual_id(params[:manual_id])
    if @projects
      render :json => {
                        :success => true,
                        :projects => @projects
                      }
    else
      render :json => {
                        :errors => @projects.errors.full_messages.join(', '),
                        :status => :unprocessable_entity
                      }
    end
  end
end