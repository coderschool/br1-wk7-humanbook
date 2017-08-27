class AddSeenAtToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :seen_at, :datetime
  end
end
