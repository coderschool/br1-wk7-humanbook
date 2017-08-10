class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recipient
      t.string :body

      t.timestamps
    end
  end
end
