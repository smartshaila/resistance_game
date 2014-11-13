class Player < ActiveRecord::Base
  has_many :player_assignments, dependent: :destroy
  has_many :roles, through: :player_assignments
  has_many :games, through: :player_assignments
end
