class CreateLadies < ActiveRecord::Migration
  def change
    create_table :ladies do |t|
      t.references :mission, index: true
      t.integer :source_id
      t.integer :target_id

      t.timestamps
    end
  end
end
