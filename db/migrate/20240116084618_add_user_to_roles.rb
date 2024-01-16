class AddUserToRoles < ActiveRecord::Migration[7.1]
  def change
    add_reference :roles, :user, null: false, foreign_key: true
  end
end
