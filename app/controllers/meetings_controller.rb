class MeetingsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  before_filter :admin_only, :only => [:destroy, :edit, :new, :create]

  def index
    @meetings = Meeting.all
    @attendance = Attendance.all

    json_meetings = @meetings.collect do |meeting|
      date = meeting.meeting_date.to_s.gsub(/(\d{4})-(\d{2})-(\d{2})/, '\2/\3/\1')
      { "date" => date,
        "title" => "1" }
    end

    temp = { "event" => json_meetings.reverse }
    logger.info('-----json-----------------')
    logger.info(temp.inspect)

    respond_to do |format|
      format.html
      format.json { render :json => { :meetings => temp } }
    end
    #render "calendar"
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(params[:meeting])

    if @meeting.save
      redirect_to @meeting, notice: 'Meeting was successfully created.'
    else
      render "new", alert: 'Meeting could not be created.'
    end
  end

  def show
    @meeting = Meeting.find(params[:id])
    @attendance = @meeting.register(current_user)
    @meeting_roles = MeetingRole.attendee_roles
    @roles_taken = @meeting.roles_taken
    @attendance.meeting.speeches.build
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy

    redirect_to meetings_path
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])

    if @meeting.update_attributes(params[:meeting])
      redirect_to root_path, notice: 'Meeting was successfully updated.'
    else
      render action: "edit"
    end
  end

  private
  def admin_only
    current_user.admin?
  end
end
