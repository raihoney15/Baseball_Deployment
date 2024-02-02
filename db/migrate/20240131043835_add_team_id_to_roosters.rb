class AddTeamIdToRoosters < ActiveRecord::Migration[7.1]
  def change
    add_reference :roosters, :team, foreign_key: true
  end
end
