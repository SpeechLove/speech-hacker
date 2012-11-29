class Meeting < ActiveRecord::Base
  attr_accessible :meeting_date, :meeting_time, :description

  has_many :attendances

  before_save :verify_date

  validates :meeting_date, :presence => true
  validates :meeting_time, :presence => true,
            :format => { :with => /\d{2}\:\d{2}/,
                         :message => "format should be HH:MM" }
  validates_length_of :description, :maximum => 255, :allow_blank => true

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
