class RenameAboutsToEditpages < ActiveRecord::Migration
  def self.up
      rename_table :abouts, :editpages
  end 
  def self.down
      rename_table :editpages, :abouts
  end
end
