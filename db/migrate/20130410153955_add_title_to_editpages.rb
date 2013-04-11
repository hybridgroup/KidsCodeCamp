class AddTitleToEditpages < ActiveRecord::Migration
  def change
    add_column :editpages, :title, :string
  end
end
