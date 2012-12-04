class ProjectsController < ApplicationController
  def index
    @projects = Manual.projects
    @user_count = User.count
    respond_to do |format|
      format.html
    end
  end

  def edit
    @project = params[:project]
    render :partial => 'form'
  end

  def projects_by_manual
  	@projects = Project.find_all_by_manual_id(params[:manual_id])
  	if @projects
  		render :json => { :success => true, 
  										  :projects => @projects}
  	else
      render :json => {
                        :errors => @projects.errors.full_messages.join(', '),
                        :status => :unprocessable_entity
                      }
  	end
  end
end
