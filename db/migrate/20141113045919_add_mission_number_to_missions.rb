class AddMissionNumberToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :mission_number, :integer
  end
end
