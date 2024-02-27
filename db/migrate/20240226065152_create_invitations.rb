class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations do |t|
      t.string :email
      t.boolean :accepted, default: false
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
