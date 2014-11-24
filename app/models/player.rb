class Player < ActiveRecord::Base
  require 'digest/sha1'

  has_many :player_assignments, dependent: :destroy
  has_many :roles, through: :player_assignments
  has_many :games, through: :player_assignments

  def calculate_password_hash(raw_password)
    # return hash
    Digest::SHA1.hexdigest(self.password_salt + raw_password)
  end
end
