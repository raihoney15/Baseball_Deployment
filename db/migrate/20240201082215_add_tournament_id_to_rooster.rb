class AddTournamentIdToRooster < ActiveRecord::Migration[7.1]
  def change
    add_reference(:roosters, :tournament, foreign_key: true)
  end
end
