class Team < ActiveRecord::Base
  belongs_to :mission
  has_many :team_votes, dependent: :destroy
  has_many :team_assignments, dependent: :destroy

  def assignments_complete?
    self.team_assignments.size == MissionCapacity.find_by(player_count: self.mission.game.player_assignments.size, mission_number: self.mission.mission_number).capacity
  end

  def team_voting_complete?
    self.team_votes.size == self.mission.game.player_assignments.size
  end

  def approved?
    self.team_votes.to_a.count(&:approve?) > self.mission.game.player_assignments.size * 0.5
  end

  def mission_voting_complete?
    assignments_complete? and self.team_assignments.all? {|ta| !ta.pass.nil? }
  end
end
