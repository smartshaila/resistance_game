class AddGameIdToLadies < ActiveRecord::Migration
  def change
    add_column :ladies, :game_id, :integer
  end
end
