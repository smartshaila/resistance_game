class Game < ActiveRecord::Base
  belongs_to :assassinated_assignment, :class_name => 'PlayerAssignment'
  has_many :player_assignments
  has_many :players, through: :player_assignments
  has_many :roles, through: :player_assignments
  has_many :missions
end
