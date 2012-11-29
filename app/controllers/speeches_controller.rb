class SpeechesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @speeches = current_user.speeches
  end

end
