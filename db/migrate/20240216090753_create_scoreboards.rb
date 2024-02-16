class CreateScoreboards < ActiveRecord::Migration[7.1]
  def change
    create_table :scoreboards do |t|
      t.integer :balls
      t.integer :hit
      t.integer :run
      t.integer :strike
      t.integer :out
      t.boolean :home_team
      t.boolean :home_away
      t.references :event, null: false, foreign_key: true
      t.references :event_inning, null: false, foreign_key: true

      t.timestamps
    end
  end
end
