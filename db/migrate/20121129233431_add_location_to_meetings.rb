class AddLocationToMeetings < ActiveRecord::Migration
  def up
  	add_column :meetings, :location, :string, :default => "", :null => false
  end

  def down
  	remove_column :meetings, :location
  end
end
