class ManualsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user
  load_and_authorize_resource

  def index
    @manuals = Manual.all
    @speeches = Hash.new
    @user = User.find(params[:user_id])
    @manuals.each do |manual|
      @speeches[manual] = @user.speeches.for_manual(manual).sort_by do |speech|
        speech.project.project_number
      end
    end
  end

  def new
    @manual = Manual.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @manuals = Manual.all
    @manual = Manual.create!(params[:manual])

    respond_to do |format|
      format.js
    end
  end

  def edit
    @manuals = Manual.all
    @manual = Manual.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @manual = Manual.find(params[:id])
    @manual.update_attributes(params[:manual])

    respond_to do |format|
      format.js
    end
  end

  private
  def find_user
    if current_user.id == params[:user_id]
      @user = current_user
    else
      @user = User.find(params[:user_id])
    end
  end
end
