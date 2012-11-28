class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, :null => false
      t.integer :project_number, :null => false
      t.references :manual, :null => false

      t.timestamps
    end
  end
end
