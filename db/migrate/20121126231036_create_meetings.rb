class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :meeting_date, :null => false
      t.string :meeting_time, :null => false
      t.string :description

      t.timestamps
    end
  end
end
