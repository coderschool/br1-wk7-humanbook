class Broadcast
  def self.new_post(post)
    ActionCable.server.broadcast "newsfeed", script: "PostsJs.updateNewsfeed(#{post.id})"
  end
end