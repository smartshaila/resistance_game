class Role < ActiveRecord::Base
  belongs_to :faction
  has_many :player_assignments, dependent: :destroy
  has_many :players, through: :player_assignments
  has_many :games, through: :player_assignments
  has_many :roles, :class_name => 'RoleRelationship', :foreign_key => 'role_id', dependent: :destroy
  has_many :revealed_roles, :class_name => 'RoleRelationship', :foreign_key => 'revealed_role_id', dependent: :destroy

  accepts_nested_attributes_for :revealed_roles, allow_destroy: true

  def revealed_roles
    RoleRelationship.where(role_id: self.id).map{|r|
      {
          revealed_role: r.revealed_role,
          faction: (r.revealed_role.faction if r.revealed_faction)
      }
    }
  end
end
