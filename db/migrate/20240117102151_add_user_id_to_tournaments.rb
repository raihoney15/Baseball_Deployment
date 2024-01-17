class AddUserIdToTournaments < ActiveRecord::Migration[7.1]
  def change
    add_reference(:tournaments, :user, foreign_key: true)
  end
end
