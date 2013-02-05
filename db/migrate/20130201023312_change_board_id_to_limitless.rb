class ChangeBoardIdToLimitless < ActiveRecord::Migration
  def up
    change_column :posts, :board_id, :integer, :limit => nil
  end

  def down
  end
end
