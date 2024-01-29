class CreateTeamLineUps < ActiveRecord::Migration[7.1]
  def change
    create_table :team_line_ups do |t|
      t.integer :batter_order
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :rooster, null: false, foreign_key: true

      t.timestamps
    end
  end
end
