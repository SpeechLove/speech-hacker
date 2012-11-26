class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :meeting, :null => false
      t.references :user, :null => false

      t.timestamps
    end
  end
end
