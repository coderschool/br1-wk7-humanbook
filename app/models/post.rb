class Post < ApplicationRecord
  belongs_to :wall_user, class_name: "User"
  belongs_to :poster, class_name: "User"

  has_many :likes, as: :item, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :body, presence: true

  mount_uploader :image, AvatarUploader

  def different_wall?
    wall_user != poster
  end
end
