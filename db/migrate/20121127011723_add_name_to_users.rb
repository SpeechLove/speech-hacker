class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :default => "", :null => false
  end
end
