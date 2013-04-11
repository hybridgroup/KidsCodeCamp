class ChangeIsAdminTypeToBoolean < ActiveRecord::Migration
  def up
    add_column :users, :is_admin_new, :boolean, :default => false
    remove_column :users, :is_admin
    rename_column :users, :is_admin_new, :is_admin
  end

  def down
    change_column :users, :is_admin, :integer, :defaul => 0
  end
end
