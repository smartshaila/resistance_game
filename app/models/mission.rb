class Mission < ActiveRecord::Base
  belongs_to :game
  has_many :teams, dependent: :destroy
  has_many :team_assignments, through: :teams
end
