class ChangeColumnsName < ActiveRecord::Migration[7.1]
  def change
    rename_column :rooster_positions, :firstbase, :first_base
    rename_column :rooster_positions, :secondbase, :second_base
    rename_column :rooster_positions, :thirdbase, :third_base
  end
end
