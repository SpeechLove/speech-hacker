class Meeting < ActiveRecord::Base
  attr_accessible :meeting_date, :meeting_time, :description, :location, :speeches_attributes

  has_many :attendances
  has_many :users, :through => :attendances
  has_many :speeches

  before_validation :verify_date

  validates :meeting_time, :presence => true,
            :format => { :with => /\d{2}\:\d{2}/,
                         :message => "format should be HH:MM" }
  validates_presence_of :location
  validates_length_of :description, :maximum => 255, :allow_blank => true
  validates_length_of :location, :maximum => 255, :allow_blank => false

  accepts_nested_attributes_for :speeches, :reject_if => proc { |attributes| attributes['title'].blank? }

  def self.order_by_most_recent_date
    order("meeting_date DESC").all
  end

  def happened?
    meeting_date < DateTime.now
  end

  def roles_taken
    self.attendances.reduce(Hash.new{ |hash, key| hash[key] = [] }) do |roles, attendance|
      roles[attendance.meeting_role_id] << attendance.user.id
      roles
    end
  end

  def attendance_for(user)
    self.attendances.find_or_initialize_by_user_id(user.id)
  end

  def formatted_full_date
    meeting_date.strftime("%A, %B %e, %Y")
  end

  def formatted_short_date
    meeting_date.strftime("%b %-d, %Y")
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
