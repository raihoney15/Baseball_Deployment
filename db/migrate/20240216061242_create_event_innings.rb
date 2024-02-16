class CreateEventInnings < ActiveRecord::Migration[7.1]
  def change
    create_table :event_innings do |t|
      t.integer :inning_number
      t.boolean :top
      t.boolean :bottom
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
