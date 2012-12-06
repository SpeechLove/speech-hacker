class ManualsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @manuals = Manual.all
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
end
