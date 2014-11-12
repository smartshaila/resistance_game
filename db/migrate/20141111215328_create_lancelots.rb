class CreateLancelots < ActiveRecord::Migration
  def change
    create_table :lancelots do |t|
      t.boolean :switched
      t.references :mission, index: true

      t.timestamps
    end
  end
end
