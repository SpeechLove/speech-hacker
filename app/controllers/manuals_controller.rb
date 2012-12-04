class ManualsController < ApplicationController

  before_filter :authenticate_user!
  #need to add authorization here so that only admins and the records' user can view this page

  def index
      @manuals = Manual.all
      if current_user.id == params[:user_id]
        @user = current_user
      else
        @user = User.find(params[:user_id])
      end
  end

  # def show
  #   @manual = Manual.find(params[:id])
  #   @speeches = current_user.speeches.for_manual(@manual) # this accesses the class method in Speech that queries the database.
  # end

end
