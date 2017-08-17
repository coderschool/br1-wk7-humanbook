# Preview all emails at http://localhost:3000/rails/mailers/post
class PostPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/post/new_post
  def new_post
    PostMailer.new_post(Post.last)
  end

end
