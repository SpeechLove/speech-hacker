class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :meeting_date, :null => false
      t.time :meeting_time, :null => false

      t.timestamps
    end
  end
end
