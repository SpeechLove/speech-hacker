class Manual < ActiveRecord::Base
  attr_accessible :name
  has_many :projects
  validates_presence_of :name


 def completed_projects(u_id)
    speeches = Speech.where({:user_id => u_id })
    #speeches = Speech.where("u_id")
    speeches = [speeches] if (speeches.class == Speech)
    speech_ids = speeches.collect{ |s| s.id }
    project_ids = speeches.collect{ |s| s.project_id }
    projects = Project.find(project_ids)

    # speeches = current_user.speeches
    # projects = speeches.collect { |speech| speech.project }
    completed = Hash.new

    projects.each do |p|
      completed[p] = speeches.find{ |s| s.project_id == p.id }
    end

    completed.group_by{ |pair| pair[0].manual_id }
  end



# def self.completed_projects(current_user)
#     speeches = current_user.speeches
#     #speeches = Speech.where("u_id")
#     #speeches = [speeches] if (speeches.class == Speech)
#     #speech_ids = speeches.collect{ |s| s.id }


#     #logger.info(speeches[0].project.inspect)

#     projects = speeches.collect { |speech| speech.project }


#     completed = Hash.new
#     # puts "HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
#     # puts speeches
#     # puts "HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
#     # puts projects

#     projects.each do |project|
#     	logger.info('---------------')
#     	logger.info(project.inspect)
#     	logger.info(project.speech.inspect)
#       completed[project] = project.speech if project.speech
#     end

#     # puts "HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"


#     completed.group_by{ |pair| pair[0].manual_id }
#   end
	def speech_count(manual, user)
		speeches = Speech.find_all_by_project_id(Project.find_by_manual_id(manual.id))
		logger.info('--------------------')
		logger.info(speeches.inspect)
		speeches.collect { |speech| speech.user_id == user.id }.count
	end

end
