class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.references :faction, index: true

      t.timestamps
    end
  end
end
