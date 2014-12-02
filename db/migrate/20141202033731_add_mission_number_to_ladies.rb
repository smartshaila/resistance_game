class AddMissionNumberToLadies < ActiveRecord::Migration
  def change
    add_column :ladies, :mission_number, :integer
  end
end
