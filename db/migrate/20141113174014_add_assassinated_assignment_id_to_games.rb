class AddAssassinatedAssignmentIdToGames < ActiveRecord::Migration
  def change
    add_reference :games, :assassinated_assignment, references: :player_assignments
  end
end
