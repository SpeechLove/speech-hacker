class CreateMeetingRoles < ActiveRecord::Migration
  def change
    create_table :meeting_roles do |t|
      t.references :meeting, :null => false
      t.references :role, :null => false
      t.references :user, :null => false

      t.timestamps
    end
  end
end
