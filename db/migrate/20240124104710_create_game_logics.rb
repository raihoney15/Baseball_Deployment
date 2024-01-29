class CreateGameLogics < ActiveRecord::Migration[7.1]
  def change
    create_table :game_logics do |t|
      t.string :move_name
      t.references :event, null: false, foreign_key: true
      t.references :move, null: false, foreign_key: true

      t.timestamps
    end
  end
end
