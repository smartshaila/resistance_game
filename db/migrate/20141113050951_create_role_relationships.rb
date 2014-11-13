class CreateRoleRelationships < ActiveRecord::Migration
  def change
    create_table :role_relationships do |t|
      t.integer :role_id
      t.integer :revealed_role_id
      t.boolean :revealed_allegiance

      t.timestamps
    end
  end
end
