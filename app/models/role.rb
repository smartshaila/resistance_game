class Role < ActiveRecord::Base
  belongs_to :faction
  has_many :player_assignments
  has_many :players, through: :player_assignments
  has_many :games, through: :player_assignments
end
