class AddValidVoteToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :valid_vote, :int
  end
end
