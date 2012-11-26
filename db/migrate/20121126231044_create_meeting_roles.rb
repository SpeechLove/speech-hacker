class CreateMeetingRoles < ActiveRecord::Migration
  def change
    create_table :meeting_roles do |t|

      t.timestamps
    end
  end
end
