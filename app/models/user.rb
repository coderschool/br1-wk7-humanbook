class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  
  # me ==> friendships
  # friendship ==> friend
  # friendships ==> friends

  validates :name, :email, presence: true
  has_secure_password

  def image_url_or_default
    image_url.presence || "http://lorempixel.com/400/200/sports/Dummy-Text/"
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
      hash = {}
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
