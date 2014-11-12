class CreateTeamVotes < ActiveRecord::Migration
  def change
    create_table :team_votes do |t|
      t.boolean :approve
      t.references :team, index: true
      t.references :player_assignment, index: true

      t.timestamps
    end
  end
end
