module PostsHelper
  def post_placeholder_message(post)
    if post.wall_user == current_user
      "What's on your mind, #{current_user.name}..."
    else
      "Write something to #{post.wall_user.name}..."
    end
  end
end
