class ChangeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :rooster_positions, :batter, :fourth_base

  end
end
  