class SetDefaultToIsAdminInUsers < ActiveRecord::Migration
  def up
    change_column :users, :is_admin, :integer, :default => 0
  end

  def down
    change_column :users, :is_admin, :integer, :default => 1
  end
end
