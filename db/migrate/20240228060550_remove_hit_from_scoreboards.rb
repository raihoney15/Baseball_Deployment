class RemoveHitFromScoreboards < ActiveRecord::Migration[7.1]
  def change
    remove_column :scoreboards, :hit
  end
end
