class CreateSpeeches < ActiveRecord::Migration
  def change
    create_table :speeches do |t|
      t.references :project, :null => false
      t.references :meeting, :null => false
      t.string     :title
      t.belongs_to :user, :null => false
      t.belongs_to :evaluator, :null => false

      t.timestamps
    end
  end
end
