class CreateRoosters < ActiveRecord::Migration[7.1]
  def change
    create_table :roosters do |t|
      t.string :name
      t.integer :jersey_number

      t.timestamps
    end
  end
end
