class Role < ActiveRecord::Base
  belongs_to :faction
  has_many :player_assignments, dependent: :destroy
  has_many :players, through: :player_assignments
  has_many :games, through: :player_assignments
  has_many :roles, :class_name => 'RoleRelationship', :foreign_key => 'role_id', dependent: :destroy
  has_many :revealed_roles, :class_name => 'RoleRelationship', :foreign_key => 'revealed_role_id', dependent: :destroy
end
