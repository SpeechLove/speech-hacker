class SpeechesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @speeches = Speech.find_all_by_user_id(current_user.id)
  end

end
