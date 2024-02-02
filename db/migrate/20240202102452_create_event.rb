class CreateEvent < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :game_type
      t.boolean :home_team
      t.boolean :away_team
      t.date :start_date
      t.string :location
      t.integer :belongs
      t.string :memo
      t.boolean :is_live
      t.integer :winning_team_id
      t.references :user, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :opponent_team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
