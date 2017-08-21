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

  def self.generate_posts(n = 5, user = nil)
    user ||= User.last
    n.times do 
      post = Post.create(body: Faker::HowIMetYourMother.quote,
        wall_user: user,
        poster: User.random_user
      )
      rand(3).times do
        post.comments.create(
          body: Faker::HowIMetYourMother.catch_phrase,
          user: User.random_user
        )
      end      
    end
  end
end
