class ManualsController < ApplicationController

	def index
		#@manual = Manual.find(params[:id])
		@manuals = Manual.all
		#@speeches = current_user.speeches.for_manual(@manual) # this accesses the class method in Speech that queries the database.
		@speeches = Hash.new
		@manuals.each do |m|
			@speeches[m] = current_user.speeches.for_manual(m)
		end

	end

	def show
		@manual = Manual.find(params[:id])
		@speeches = current_user.speeches.for_manual(@manual) # this accesses the class method in Speech that queries the database.
	end



end
