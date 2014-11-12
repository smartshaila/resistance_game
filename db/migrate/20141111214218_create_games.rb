class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :date
      t.boolean :public_vote
      t.boolean :public_lancelot_switch

      t.timestamps
    end
  end
end
