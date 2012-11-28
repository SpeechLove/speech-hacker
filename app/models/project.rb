class Project < ActiveRecord::Base
  attr_accessible :manual_id, :name, :number
  belongs_to :manual
end
