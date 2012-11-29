class SpeechesController < ApplicationController

  def index
    @speeches = Speeches.all
  end

end
