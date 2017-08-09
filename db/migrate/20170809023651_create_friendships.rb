class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :friend_id

      t.timestamps
    end
  end
end
