class Project < ActiveRecord::Base
  attr_accessible :manual_id, :name, :project_number
  belongs_to :manual
  validates_presence_of :name
  validates_presence_of :manual_id
  validates_presence_of :project_number

  def sorted_by_manual
    @grouped = Project.all.group_by{ |p| p.manual_id }
  end

end
