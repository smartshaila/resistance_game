class Game < ActiveRecord::Base
  belongs_to :assassinated_assignment, class_name: 'PlayerAssignment'
  has_many :player_assignments, dependent: :destroy
  has_many :missions, dependent: :destroy
  has_many :players, through: :player_assignments
  has_many :roles, through: :player_assignments
  has_many :teams, through: :missions
  has_many :ladies

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
    half_of_missions = mission_capacities.size * 0.5
    unless [self.missions.to_a.count {|m| m.result }, self.missions.to_a.count {|m| m.result == false }].any? {|r| r > half_of_missions}
      m = Mission.create(game: self, mission_number: self.missions.size)
      Team.create(mission: m)
      if self.ladies.empty?
        Lady.create(game: self, mission_number: half_of_missions.floor, source: self.player_assignments.max_by(&:seat_number))
      end
      # This needs fixing:
      l = self.ladies.where(mission_number: m.mission_number-1)
      unless l.empty? or l.first.target.nil?
        Lady.create(game: self, mission_number: m.mission_number, source: l.first.target)
      end
    end
  end

  def current_lady
      self.ladies.max_by(&:mission_number)
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
      if (mission_results[true] or 0) > (mission_results[false] or 0) or (!self.assassinated_assignment.nil? and self.assassinated_assignment.role.name != 'Merlin')
        Faction.find_by(name: 'Good')
      else
        Faction.find_by(name: 'Evil')
      end
    end
  end

  def status
    if complete?
      method = ''
      if !self.assassinated_assignment.nil? and self.assassinated_assignment.role.name == 'Merlin'
        method = "assassination of #{self.assassinated_assignment.player.name}"
      elsif current_team.team_voting_complete? and !current_team.approved?
        method = "team rejections"
      else
        method = "missions"
      end
      "Game over. #{winning_faction.name} wins through #{method}!"
    elsif current_mission.mission_number == current_lady.mission_number and current_lady.target.nil?
      "Waiting for #{current_lady.source.player.name.capitalize} to use the Lady on someone..."
    elsif !current_team.assignments_complete?
      "Waiting for #{current_king.player.name.capitalize} to pick a team of #{current_mission.capacity.capacity} players..."
    elsif !current_team.team_voting_complete?
      pending_player_assignments = self.player_assignments - current_team.team_votes.where.not(approve: nil).map{|vote| vote.player_assignment}
      output = pending_player_assignments.map{|assignment| assignment.player.name}.to_sentence
      "Waiting for #{output} to vote on the team..."
    elsif !current_team.mission_voting_complete?
      "Waiting for #{current_team.team_assignments.where(pass: nil).map{|assignment| assignment.player_assignment.player.name}.to_sentence} to vote on the mission..."
    else
      'Game over? [This is a bug]'
    end
  end
end
