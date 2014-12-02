class RemoveMissionIdFromLadies < ActiveRecord::Migration
  def change
    remove_column :ladies, :mission_id, :integer
  end
end
