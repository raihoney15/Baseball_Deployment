class AddPositionToTeamLineUps < ActiveRecord::Migration[7.1]
  def change
    add_reference :team_line_ups, :position, null: false, foreign_key: true
  end
end
