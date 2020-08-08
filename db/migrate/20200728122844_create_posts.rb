class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :memo
      t.string :video
      t.string :genre
      t.string :music
      t.integer :user_id

      t.timestamps
    end
  end
end
