module PostsHelper
  def post_placeholder_message(post)
    if post.wall_user == current_user
      "What's on your mind, #{current_user.name}..."
    else
      "Write something to #{post.wall_user.name}..."
    end
  end

  def mentions_text(post)
      answer = ""
      if post.mentions.any?
        answer << "with #{post.mentions.first.user.name}"
        if post.mentions.count > 1
          num = " and #{pluralize(post.mentions.count - 1, "other")}"
          answer << num
        end
      end
      answer
  end
end
