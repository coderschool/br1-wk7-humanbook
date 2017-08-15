class Post < ApplicationRecord
  belongs_to :wall_user, class_name: "User"
  belongs_to :poster, class_name: "User"

  validates :body, presence: true

  def different_wall?
    wall_user != poster
  end
end
