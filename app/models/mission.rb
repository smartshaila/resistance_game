class Mission < ActiveRecord::Base
  belongs_to :game
  has_many :teams
  has_many :team_assignments, through: :teams
end
