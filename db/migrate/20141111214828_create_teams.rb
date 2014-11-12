class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :mission, index: true

      t.timestamps
    end
  end
end
