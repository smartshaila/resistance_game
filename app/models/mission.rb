class Mission < ActiveRecord::Base
  belongs_to :game
  has_many :teams, dependent: :destroy
  has_many :team_assignments, through: :teams

  def current_team
    self.teams.max
  end

  def rejection_count
    self.teams.to_a.count {|team| team.team_voting_complete? and !team.approved?}
  end

  def voting_results
    current_team.team_assignments.group_by(&:pass).map{|result, assignments|{result => assignments.size}}.inject({}){|res, curr| res.merge(curr)} if current_team.mission_voting_complete?
  end

  def result
    (voting_results[false] or 0) < capacity.fail_count unless voting_results.nil?
  end

  def capacity
    MissionCapacity.find_by(player_count: self.game.player_assignments.size, mission_number: self.mission_number)
  end
end
