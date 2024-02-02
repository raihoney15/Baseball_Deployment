class CreateOpponentTeam < ActiveRecord::Migration[7.1]
  def change
    create_table :opponent_teams do |t|
      t.string :name
      t.string :short_name
      t.references :user, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true
      t.references :team, null: true, foreign_key: true

      t.timestamps
    end
  end
end
