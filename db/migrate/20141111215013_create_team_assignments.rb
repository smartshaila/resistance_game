class CreateTeamAssignments < ActiveRecord::Migration
  def change
    create_table :team_assignments do |t|
      t.boolean :pass
      t.references :team, index: true
      t.references :player_assignment, index: true

      t.timestamps
    end
  end
end
