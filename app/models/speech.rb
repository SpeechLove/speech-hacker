class Speech < ActiveRecord::Base
  attr_accessible :project_id, :meeting, :title, :user_id, :evaluator

  belongs_to :user
  belongs_to :evaluator, :class_name => "User"
  belongs_to :project
  belongs_to :meeting

  validates :project, :meeting, :user, :presence => true
  accepts_nested_attributes_for :project
end
