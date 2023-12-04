class CreateGitHubScorecards < ActiveRecord::Migration[7.0]
  def change
    create_table :git_hub_scorecards do |t|
      t.string :username
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
