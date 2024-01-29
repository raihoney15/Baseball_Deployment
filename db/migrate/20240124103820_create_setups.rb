class CreateSetups < ActiveRecord::Migration[7.1]
  def change
    create_table :setups do |t|
      t.integer :inning_rounds
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
