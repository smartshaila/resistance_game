class CreatePlayerAssignments < ActiveRecord::Migration
  def change
    create_table :player_assignments do |t|
      t.integer :seat_number
      t.references :game, index: true
      t.references :player, index: true
      t.references :role, index: true

      t.timestamps
    end
  end
end
