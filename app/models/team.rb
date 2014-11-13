class Team < ActiveRecord::Base
  belongs_to :mission
  has_many :team_votes, dependent: :destroy
  has_many :team_assignments, dependent: :destroy
end
