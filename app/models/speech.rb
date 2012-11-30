class Speech < ActiveRecord::Base
  attr_accessible :project_id, :meeting_id, :title, :user_id, :evaluator_id

  belongs_to :user, :class_name => "User"
  belongs_to :evaluator, :class_name => "User"
  belongs_to :project
  belongs_to :meeting
  delegate :manual, :to => :project

  validates_presence_of :project_id, :meeting_id, :user_id, :evaluator_id

  def self.for_manual(manual)
  	#sql query for joining manual and project tables on the manual id //from Robert!
  	joins(:project).where("projects.manual_id = ?", [manual.id])
  end
end
