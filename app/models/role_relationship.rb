class RoleRelationship < ActiveRecord::Base
  belongs_to :role, :class_name => 'Role'
  belongs_to :revealed_role, :class_name => 'Role'
end
