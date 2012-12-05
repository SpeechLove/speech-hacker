class Manual < ActiveRecord::Base
  attr_accessible :name
  has_many :projects
  validates_presence_of :name

  def self.projects
    projects = Hash.new
    Manual.all.each { |m| projects[m] = m.projects }
    projects
  end
 
	# def speech_count(manual, user)
	# 	speeches = Speech.find_all_by_project_id(Project.find_by_manual_id(manual.id))
	# 	speeches.collect { |speech| speech.user_id == user.id }.count
	# end

end
