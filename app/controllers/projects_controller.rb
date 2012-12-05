class ProjectsController < ApplicationController
  def index
    @projects = Manual.projects
    @user_count = User.count
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create

  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:project][:id])
    @project.update_attributes(params[:project])
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
