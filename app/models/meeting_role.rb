class MeetingRole < ActiveRecord::Base
  attr_accessible :title, :null => false, :unique => true
end
