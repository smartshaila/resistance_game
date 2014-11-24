class RenameColumnPasswordToPasswordHash < ActiveRecord::Migration
  def change
    rename_column :players, :password, :password_hash
  end
end
