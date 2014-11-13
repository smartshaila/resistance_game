class CreateMissionCapacities < ActiveRecord::Migration
  def change
    create_table :mission_capacities do |t|
      t.integer :player_count
      t.integer :mission_number
      t.integer :capacity
      t.integer :fail_count

      t.timestamps
    end
  end
end
