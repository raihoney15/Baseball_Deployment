class CreateOpponentRoosters < ActiveRecord::Migration[7.1]
  def change
    create_table :opponent_roosters do |t|
      t.string :name
      t.integer :jersey_number
      t.references :user, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true
      t.references :opponent_team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
