class CreateOpponentTeamLineUps < ActiveRecord::Migration[7.1]
  def change
    create_table :opponent_team_line_ups do |t|
      t.integer :batter_order
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :opponent_rooster, null: false, foreign_key: true
      t.references :opponent_team, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true

      t.timestamps
    end
  end
end
