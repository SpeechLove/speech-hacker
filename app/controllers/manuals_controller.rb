class ManualsController < ApplicationController

	def index
		@manuals = Manual.all
	end

	def show
		@manual = Manual.find(params[:id])
		@speeches = current_user.speeches.select { |speech| speech.manual_id == @manual.id }
		@speeches.each do |speech|
			logger.info('-----------------speech projects------------------------')
			logger.info(@speeches.inspect)
		end
	end



end
