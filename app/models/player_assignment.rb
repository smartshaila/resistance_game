class PlayerAssignment < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :role
  has_many :sources, :class_name => 'Lady', :foreign_key => 'source_id', dependent: :destroy
  has_many :targets, :class_name => 'Lady', :foreign_key => 'target_id', dependent: :destroy
  default_scope { includes(:player).order('players.name ASC') }

  def visible_relationships
    self.role.revealed_roles.map{|relation|
      found_assignment = self.game.player_assignments.find{|a| a.role == relation[:revealed_role]}
      if found_assignment
        {
            player: found_assignment.player,
            faction: relation[:faction]
        }
      end
    }.compact
  end

  def winner?
    self.game.winning_faction == self.role.faction
  end
end