class ManualsController < ApplicationController

  #need to add authorization here so that only admins and the records' user can view this page

  def index
    @manuals = Manual.all
    if current_user.superadmin?
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end

  # def show
  #   @manual = Manual.find(params[:id])
  #   @speeches = current_user.speeches.for_manual(@manual) # this accesses the class method in Speech that queries the database.
  # end



end
