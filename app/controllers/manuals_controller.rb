class ManualsController < ApplicationController

	def index
		@manuals = Manual.all
	end

	def show
		@manual = Manual.find(params[:id])
		@speeches = current_user.speeches.for_manual(@manual) # this accesses the class method in Speech that queries the database.
	end



end
