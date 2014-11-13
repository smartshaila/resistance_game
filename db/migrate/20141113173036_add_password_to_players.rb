class AddPasswordToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :password, :string
  end
end
