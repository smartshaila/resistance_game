class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.references :game, index: true

      t.timestamps
    end
  end
end
