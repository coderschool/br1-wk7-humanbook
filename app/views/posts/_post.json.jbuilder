json.extract! post, :id, :body, :created_at, :updated_at
json.poster post.poster, :id, :name, :email, :gender, :avatar, :image_url_or_default
json.wall_user post.wall_user, :id, :name, :email, :gender, :avatar, :image_url_or_default