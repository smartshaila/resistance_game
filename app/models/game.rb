class Game < ActiveRecord::Base
  belongs_to :assassinated_assignment, :class_name => 'PlayerAssignment'
  has_many :player_assignments, dependent: :destroy
  has_many :missions, dependent: :destroy
  has_many :players, through: :player_assignments
  has_many :roles, through: :player_assignments
  has_many :teams, through: :missions

  def game_setup (players, roles)
    set_assignments(players, roles)
    m = Mission.create(game: self, mission_number: 0)
    Team.create(mission: m)
  end

  def set_assignments (players, roles)
    roles.shuffle!
    players.rotate!(rand(players.size))
    players.each_with_index { |player,index|
      p = PlayerAssignment.new
      p.player_id = player.to_i
      p.seat_number = index
      p.role_id = roles[index].to_i
      p.game = self
      p.save
    }
  end

  def current_king
    no_of_teams = self.teams.select{|t| t.team_assignments.size > 0}.size
    no_of_players = self.player_assignments.size
    king_seat = no_of_teams % no_of_players
    self.player_assignments.where("seat_number = ?", king_seat).first
  end
end