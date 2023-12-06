class CreateContributorRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :contributor_ratings do |t|
      t.references :contributor, foreign_key: true
      t.references :rating, foreign_key: true
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
