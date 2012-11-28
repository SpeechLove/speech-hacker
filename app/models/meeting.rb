class Meeting < ActiveRecord::Base
  attr_accessible :meeting_date, :meeting_time, :description

  has_many :attendances
  has_many :users, :through => :attendances

  before_validation :parse_date

  validates :meeting_date, :presence => true
  validates :meeting_time, :presence => true,
            :format => { :with => /\d{2}\:\d{2}/,
                         :message => "format should be HH:MM" }
  validates_length_of :description, :maximum => 255, :allow_blank => true

  private
  def parse_date
    if (self.meeting_date.to_s =~ /\d{4}-\d{2}-\d{2}/) == nil
      logger.info("----------------meeting_date------------------")
      logger.info(self.meeting_date)
      self.errors.add :meeting_date,
              "format should be MM/DD/YYYY"
      return false
    end

    split_date = self.meeting_date.to_s.split('-')
    self.meeting_date = Date.parse("#{split_date[0]}-#{split_date[2]}-#{split_date[1]}")
    logger.info("--------------------------------")
    logger.info(self.meeting_date)
  end
end
