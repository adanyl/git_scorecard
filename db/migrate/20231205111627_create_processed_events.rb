class CreateProcessedEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :processed_events do |t|
      t.string :git_event_id

      t.timestamps
    end
  end
end
