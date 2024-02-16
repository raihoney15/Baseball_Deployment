class CreateRoosterPositions < ActiveRecord::Migration[7.1]
  def change
    create_table :rooster_positions do |t|
      t.integer :catcher
      t.integer :batter
      t.integer :firstbase
      t.integer :secondbase
      t.integer :thirdbase
      t.integer :pitcher
      t.integer :shortstop
      t.integer :rightfield
      t.integer :leftfield
      t.integer :centerfield
      t.references :user, null: false, foreign_key: true
      t.references :scoreboard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
