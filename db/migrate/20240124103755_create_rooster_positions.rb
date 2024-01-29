class CreateRoosterPositions < ActiveRecord::Migration[7.1]
  def change
    create_table :rooster_positions do |t|
      t.integer :b_catcher
      t.integer :b_firstbase
      t.integer :b_secondbase
      t.integer :b_thirdbase
      t.integer :f_pitcher
      t.integer :f_shortstop
      t.integer :f_rightfield
      t.integer :f_leftfield
      t.integer :f_centerfield
      t.references :user, null: false, foreign_key: true
      t.references :scoreboard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
