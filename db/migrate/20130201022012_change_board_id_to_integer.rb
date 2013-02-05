class ChangeBoardIdToInteger < ActiveRecord::Migration
  def up
    change_table :posts do |t|
      t.change :board_id, :integer
    end
  end

  def down
  end
end
