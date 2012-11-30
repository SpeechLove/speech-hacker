class ManualsController < ApplicationController

	def index
		@manuals = Manual.all
		@speeches = Hash.new
		@speeches_test = current_user.speeches
		logger.info('--------current user--------------')
		logger.info(current_user.inspect)
		logger.info('------------database speeches---------')
		logger.info(Speech.all)
		@manuals.each do |m|
			@speeches[m] = current_user.speeches.for_manual(m)
		end
		logger.info('------------speeches hash----------')
		logger.info(@speeches.inspect)

	end

	# def show
	# 	@manual = Manual.find(params[:id])
	# 	@speeches = current_user.speeches.for_manual(@manual) # this accesses the class method in Speech that queries the database.
	# end



end
