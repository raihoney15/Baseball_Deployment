class AddRoosterNameToCommentaries < ActiveRecord::Migration[7.1]
  def change
    add_column :commentaries, :rooster_name, :string
    add_column :commentaries, :move_name, :string
  end
end
