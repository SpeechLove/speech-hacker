class UsersController < ApplicationController
before_filter :authenticate_user!

  def index
    if(current_user.has_role?(:admin))
      @users = User.all
    else
      redirect_to root_path, :notice => "You are not authorized to access this page."
    end
  end
end