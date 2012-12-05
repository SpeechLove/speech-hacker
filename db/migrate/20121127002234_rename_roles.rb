class RenameRoles < ActiveRecord::Migration
  def change
    rename_table :roles, :meeting_roles
  end
end
