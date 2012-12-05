class SpeechesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @speeches = current_user.speeches.sort_by { |speech| speech.project.project_number }
  end

end
