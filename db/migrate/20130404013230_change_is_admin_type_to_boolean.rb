class ChangeIsAdminTypeToBoolean < ActiveRecord::Migration
  def up
    change_column :users, :is_admin, :boolean, :default => false
  end

  def down
    change_column :users, :is_admin, :integer, :defaul => 0
  end
end
