class Project < ActiveRecord::Base
  attr_accessible :manual_id, :name, :project_number
  belongs_to :manual
  has_many :speeches

  validates_presence_of :name, :manual_id, :project_number

  def sorted_by_manual
    @grouped = Project.all.group_by{ |p| p.manual_id }
  end

end
