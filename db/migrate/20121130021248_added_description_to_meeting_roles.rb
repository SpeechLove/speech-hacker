class AddedDescriptionToMeetingRoles < ActiveRecord::Migration
  def change
    add_column :meeting_roles, :description, :text
  end
end
