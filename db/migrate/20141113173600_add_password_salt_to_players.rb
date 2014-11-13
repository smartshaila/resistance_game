class AddPasswordSaltToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :password_salt, :string
  end
end
