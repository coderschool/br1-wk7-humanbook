class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.string :image
      t.integer :wall_user_id
      t.integer :poster_id

      t.timestamps
    end
  end
end
