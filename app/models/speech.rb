class Speech < ActiveRecord::Base
  attr_accessible :project_id, :meeting, :meeting_id, :title, :user_id, :evaluator

  belongs_to :user
  belongs_to :evaluator, :class_name => "User"
  belongs_to :project
  belongs_to :meeting
  delegate :manual, :to => :project

  validates :project_id, :meeting, :user_id, :presence => true
  accepts_nested_attributes_for :project

  def self.for_manual(manual)
    #sql query for joining manual and project tables on the manual id //from Robert!
    joins(:project).where("projects.manual_id = ?", [manual.id])
  end
end
