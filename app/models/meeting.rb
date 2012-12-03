class Meeting < ActiveRecord::Base
  attr_accessible :meeting_date, :meeting_time, :description, :location, :speeches_attributes

  has_many :attendances
  has_many :users, :through => :attendances
  has_many :speeches

  before_save :verify_date

  validates :meeting_time, :presence => true,
            :format => { :with => /\d{2}\:\d{2}/,
                         :message => "format should be HH:MM" }
  validates_presence_of :meeting_date, :location
  validates_length_of :description, :maximum => 255, :allow_blank => true
  validates_length_of :location, :maximum => 255, :allow_blank => false

  accepts_nested_attributes_for :speeches


  def to_hash(user)
      date = meeting_date.to_s.gsub(/(\d{4})-(\d{2})-(\d{2})/, '\2/\3/\1')
      hashed_meeting = { "date" => date,
                        "time" => meeting_time,
                        "location" => location,
                        "month" => $2,
                        "year" => $1
                        # "attending" => user.attending?(self),
                        # #"meeting_role" => user.meeting_role(self),
                        # "admin" => user.admin?
                      }
  end

  def self.to_json(meetings, user)
    formatted_meetings = meetings.collect do |meeting|
      meeting.to_hash(user)
    end
    json_meetings = { "event" => formatted_meetings }
  end


  private
  def verify_date
    if (self.meeting_date.to_s =~ /\d{4}-\d{2}-\d{2}/) == nil
      self.errors.add :meeting_date,
              "format should be YYYY-MM-DD"
      return false
    end

    # split_date = self.meeting_date.to_s.split('-')
    # self.meeting_date = Date.parse("#{split_date[0]}-#{split_date[2]}-#{split_date[1]}")
  end
end
