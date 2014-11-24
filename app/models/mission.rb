class Mission < ActiveRecord::Base
  belongs_to :game
  has_many :teams, dependent: :destroy
  has_many :team_assignments, through: :teams

  def current_team
    self.teams.to_a.find {|team| team.team_voting_complete? and team.approved?}
  end

  def rejection_count
    self.teams.to_a.count {|team| team.team_voting_complete? and !team.approved?}
  end

  def result
    current_team.team_assignments.all? {|assignment| assignment.pass} unless (current_team.nil? or !current_team.mission_voting_complete?)
  end

  def capacity
    MissionCapacity.find_by(player_count: self.game.player_assignments.size, mission_number: self.mission_number).first
  end
end
