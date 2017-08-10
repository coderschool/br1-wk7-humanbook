class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"

  # me ==> friendships
  # friendship ==> friend
  # friendships ==> friends

  validates :name, :email, presence: true
  has_secure_password

  def self.from_omniauth(auth)
    # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
    # and figure out how to get email for this user.
    # Note that Facebook sometimes does not return email,
    # in that case you can use facebook-id@facebook.com as a workaround
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    user = where(email: email).first_or_initialize
    user.image_url = auth[:info][:image]
    user.name = auth[:info][:name]
    user.password = SecureRandom.hex
    #
    # Set other properties on user here. Just generate a random password. User does not have to use it.
    # You may want to call user.save! to figure out why user can't save
    #
    # Finally:
    # - if user doesn't save, return false
    # - if user did save, return user
    user.save && user
  end

  def image_url_or_default
    image_url.presence || "http://lorempixel.com/128/128/sports/Fake-User/"
  end

  def add_friend(another_user)
    friends << another_user
  end

  def is_friend?(another_user)
    friends.include?(another_user)
  end

  def self.generate_users(n = 5, gender = "female")
    url = "https://randomuser.me/api?results=#{n}&gender=#{gender}"
    body = HTTP.get(url).parse
    body["results"].each do |person|
      hash = {gender: gender}
      hash[:name] = person["name"]["first"] + " " + person["name"]["last"]
      hash[:email] = person["email"]
      hash[:password] = person["login"]["password"]
      hash[:image_url] = person["picture"]["large"]
      User.create! hash
    end
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
end
