class RenameTableAndRemoveColumn < ActiveRecord::Migration[7.0]
  def change
    rename_table :git_hub_scorecards, :contributors
    remove_column :contributors, :score
  end
end
