class CreatePitchingStats < ActiveRecord::Migration[7.1]
  def change
    create_table :pitching_stats do |t|
      t.integer :pitch
      t.references :event, null: false, foreign_key: true
      t.references :scoreboard, null: false, foreign_key: true
      t.references :team, null: true, foreign_key: true
      t.references :opponent_team, null: true, foreign_key: true
      t.references :rooster, null: true, foreign_key: true
      t.references :opponent_rooster, null: true, foreign_key: true

      t.timestamps
    end
  end
end
