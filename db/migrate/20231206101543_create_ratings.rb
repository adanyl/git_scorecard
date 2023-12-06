class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
