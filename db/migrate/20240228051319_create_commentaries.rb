class CreateCommentaries < ActiveRecord::Migration[7.1]
  def change
    create_table :commentaries do |t|
      t.text :text
      t.references :rooster, null: true, foreign_key: true
      t.references :opponent_rooster, null: true, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
