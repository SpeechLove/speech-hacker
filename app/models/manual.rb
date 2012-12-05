class Manual < ActiveRecord::Base
  attr_accessible :name
  has_many :projects
  validates_presence_of :name

  # def self.projects
  #   projects = Hash.new
  #   Manual.all.each { |m| projects[m] = m.projects }
  #   projects
  # end
end
