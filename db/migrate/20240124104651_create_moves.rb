class CreateMoves < ActiveRecord::Migration[7.1]
  def change
    create_table :moves do |t|
      t.string :move_name

      t.timestamps
    end
  end
end
