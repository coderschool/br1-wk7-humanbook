class Like < ApplicationRecord
  belongs_to :user
  belongs_to :item, polymorphic: true

  def user_name
    user.name
  end
end
