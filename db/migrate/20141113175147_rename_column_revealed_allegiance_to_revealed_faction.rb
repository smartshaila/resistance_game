class RenameColumnRevealedAllegianceToRevealedFaction < ActiveRecord::Migration
  def change
    rename_column :role_relationships, :revealed_allegiance, :revealed_faction
  end
end
