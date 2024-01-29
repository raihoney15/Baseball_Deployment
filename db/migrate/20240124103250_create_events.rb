class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :team
      t.string :op_team
      t.string :start_date
      t.string :date
      t.date :end_date
      t.string :location
      t.boolean :is_live
      t.integer :winning_team_id
      t.references :team, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
