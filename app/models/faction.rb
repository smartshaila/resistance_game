class Faction < ActiveRecord::Base
  has_many :roles, dependent: :destroy
end
