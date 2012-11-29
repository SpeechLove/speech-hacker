class ProjectsController < ApplicationController
  def index
    @projects = Project.sorted_by_manual
    respond_to do |format|
      format.html
    end
  end
end
