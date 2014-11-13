class PlayerAssignment < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :role
  has_many :sources, :class_name => 'Lady', :foreign_key => 'source_id', dependent: :destroy
  has_many :targets, :class_name => 'Lady', :foreign_key => 'target_id', dependent: :destroy
end
