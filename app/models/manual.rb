class Manual < ActiveRecord::Base
  attr_accessible :name
  has_many :projects
  validates_presence_of :name
end