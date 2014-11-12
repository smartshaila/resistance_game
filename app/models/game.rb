class Game < ActiveRecord::Base
  has_many :player_assignments
  has_many :players, through: :player_assignments
  has_many :roles, through: :player_assignments
  has_many :missions
end
