class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :user_id
      t.string :board_id
      t.text :body

      t.timestamps
    end
  end
end
