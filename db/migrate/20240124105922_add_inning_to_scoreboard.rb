class AddInningToScoreboard < ActiveRecord::Migration[7.1]
  def change
    add_reference :scoreboards, :scoreboard, null: false, foreign_key: true
  end
end
