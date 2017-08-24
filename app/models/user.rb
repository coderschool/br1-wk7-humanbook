class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"

  has_many :posts, -> {order("updated_at DESC")}, dependent: :destroy, foreign_key: "poster_id"
  has_many :wall_posts, -> {order("updated_at DESC")}, dependent: :destroy, foreign_key: "wall_user_id", class_name: "Post"

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  # me ==> friendships
  # friendship ==> friend
  # friendships ==> friends

  validates :name, :email, presence: true
  has_secure_password

  def name_or_email
    name.presence || email
  end

  def self.from_omniauth(auth)
    # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
    # and figure out how to get email for this user.
    # Note that Facebook sometimes does not return email,
    # in that case you can use facebook-id@facebook.com as a workaround
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    user = where(email: email).first_or_initialize
    if url = auth[:info][:image]
      user.remote_avatar_url = url.sub("http:", "https:") + "?type=large"
    end
    user.name = auth[:info][:name]
    user.password = SecureRandom.hex
    user.auth_hash = auth
    #
    # Set other properties on user here. Just generate a random password. User does not have to use it.
    # You may want to call user.save! to figure out why user can't save
    #
    # Finally:
    # - if user doesn't save, return false
    # - if user did save, return user
    user.save
    user
  end

  def image_url_or_default
    avatar.url || "http://lorempixel.com/128/128/sports/Fake-User/"
  end

  def add_friend(another_user)
    friends << another_user
  end

  def is_friend?(another_user)
    friends.include?(another_user)
  end

  def self.autocomplete(name)
    User.where("name ILIKE ? ", "%#{name}%")
  end

  def self.generate_users(n = 5, gender = "female")
    url = "https://randomuser.me/api?results=#{n}&gender=#{gender}"
    body = HTTP.get(url).parse
    body["results"].each do |person|
      hash = {gender: gender}
      hash[:name] = person["name"]["first"] + " " + person["name"]["last"]
      hash[:email] = person["email"]
      hash[:password] = person["login"]["password"]
      hash[:remote_avatar_url] = person["picture"]["large"]
      User.create! hash
    end
  end

  def self.generate_test_user_fast
    User.create(
      name: "Quy #{rand(100)}",
      email: "phu#{rand(100)}@vo.com",
      password: "monster"
    )
  end

  # EXPLANATION[]
  # def friends
  #   # go look at each of my friendship and get friend_id
  #   # then look up in User for the one with the id == friend_id
  #   results = []
  #   friendships.each do |fs|
  #     results << User.find(fs.friend_id)
  #   end
  #   results
  # end

  def friend_names
    friends.map{|e| e.name}
  end

  def friends_count
    friends.count
  end

  def inverse_friendships
    Friendship.where(friend_id: id)
  end

  # NOTE: this is inefficient
  def inverse_friends
    Friendship.where(friend_id: id).map{|e| e.user}
  end

  def inverse_friends_count
    inverse_friends.count
  end

  def male?
    gender == "male"
  end

  def toggle_like!(item)
    if like = likes.where(item: item).first
      like.destroy
    else
      likes.where(item: item).create!
    end
  end

  def likes?(item)
    likes.where(item: item).exists?
  end

  def self.random_user
    User.offset(rand(User.count)).first
  end
end
