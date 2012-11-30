class ProjectsController < ApplicationController
  def index
    @projects = Project.sorted_by_manual
    respond_to do |format|
      format.html
    end
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
