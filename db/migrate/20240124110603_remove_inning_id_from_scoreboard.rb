class RemoveInningIdFromScoreboard < ActiveRecord::Migration[7.1]
  def change
    remove_column :scoreboards, :inning_id, :integer
  end
end
