class ManualsController < ApplicationController

	def index
		@manuals = Manual.all
	end

	def show
		@manual = Manual.find(params[:id])

		#probably should be able to get these through speeches or something
		@projects = Manual.completed_projects(current_user)
	end



end
