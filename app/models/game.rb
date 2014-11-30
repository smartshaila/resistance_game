class Game < ActiveRecord::Base
  belongs_to :assassinated_assignment, class_name: 'PlayerAssignment'
  has_many :player_assignments, dependent: :destroy
  has_many :missions, dependent: :destroy
  has_many :players, through: :player_assignments
  has_many :roles, through: :player_assignments
  has_many :teams, through: :missions

  def game_setup (players, roles)
    set_assignments(players, roles)
    increment_mission
  end

  def set_assignments (players, roles)
    roles.shuffle!
    players.rotate!(rand(players.size))
    players.each_with_index {|player,index|
      p = PlayerAssignment.new
      p.player_id = player.to_i
      p.seat_number = index
      p.role_id = roles[index].to_i
      p.game = self
      p.save
    }
  end

  def increment_mission
    unless [self.missions.to_a.count {|m| m.result }, self.missions.to_a.count {|m| m.result == false }].any? {|r| r > mission_capacities.size * 0.5}
      m = Mission.create(game: self, mission_number: self.missions.size)
      Team.create(mission: m)
    end
  end

  def current_king
    no_of_teams = self.teams.to_a.count {|t| t.assignments_complete? and t.team_voting_complete?}
    no_of_players = self.player_assignments.size
    king_seat = no_of_teams % no_of_players
    self.player_assignments.where("seat_number = ?", king_seat).first
  end

  def current_mission
    self.missions.max_by(&:mission_number)
  end

  def current_team
    current_mission.current_team
  end

  def mission_capacities
    MissionCapacity.where player_count: self.player_assignments.size
  end

  def complete?
    !assassinated_assignment.nil? or (current_team.team_voting_complete? and (!current_team.approved? or current_team.mission_voting_complete?))
  end

  def mission_results
    self.missions.group_by(&:result).map{|result, missions| {result => missions.size}}.inject({}){|res, curr| res.merge(curr)}
  end

  def winning_faction
    if self.complete?
      if mission_results[true] > mission_results[false] or (!self.assassinated_assignment.nil? and self.assassinated_assignment.role.name != 'Merlin')
        Faction.find_by(name: 'Good')
      else
        Faction.find_by(name: 'Evil')
      end
    end
  end

  def status
    if !current_team.assignments_complete?
      "Waiting for #{current_king.player.name.capitalize} to pick a team of #{current_mission.capacity.capacity} players..."
    elsif !current_team.team_voting_complete?
      pending_player_assignments = self.player_assignments - current_team.team_votes.where.not(approve: nil).map{|vote| vote.player_assignment}
      output = pending_player_assignments.map{|assignment| assignment.player.name}.to_sentence
      "Waiting for #{output} to vote on the team..."
    elsif !current_team.mission_voting_complete?
      "Waiting for #{current_team.team_assignments.where(pass: nil).map{|assignment| assignment.player_assignment.player.name}.to_sentence} to vote on the mission..."
    else
      'Game over!'
    end
  end
end
