class Speech < ActiveRecord::Base
  attr_accessible :project_id, :meeting_id, :title, :user_id, :evaluator_id

  belongs_to :user, :class_name => "User"
  belongs_to :evaluator, :class_name => "User"

  validates_presence_of :project_id, :meeting_id, :user_id, :evaluator_id
end
