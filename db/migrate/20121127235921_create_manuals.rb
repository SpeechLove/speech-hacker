class CreateManuals < ActiveRecord::Migration
  def change
    create_table :manuals do |t|
      t.string :name, :null => false, :unique => true

      t.timestamps
    end
  end
end
