class PostsController < ApplicationController
  before_action :require_login
  
  def create
    @post = current_user.posts.build post_params
    @post.wall_user ||= current_user

    if @post.save
      PostMailer.new_post(@post).deliver
      NotifySlack.new.notify_new_post(@post, url_for(@post))
    else
      flash[:error] = @post.errors.full_messages.to_sentence
    end

    redirect_back fallback_location: root_path
  end

  def show
    @post = Post.find params[:id]
  end

  private

  def post_params
    params.require(:post).permit(:body, :wall_user_id, :image)
  end
end
