class CreateStaffInvites < ActiveRecord::Migration[7.1]
  def change
    create_table :staff_invites do |t|
      t.string :email
      t.string :resource_type
      t.integer :resouces_id
      t.integer :sender_id
      t.integer :reciver_id
      t.references :team, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
