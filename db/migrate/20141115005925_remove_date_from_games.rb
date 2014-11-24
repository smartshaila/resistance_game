class RemoveDateFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :date, :datetime
  end
end
