class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  validates :body, presence: true

  def self.unseen
    where(seen_at: nil)
  end

  def mark_as_seen!
    self.update_column :seen_at, Time.now
  end
end
