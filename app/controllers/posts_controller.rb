class PostsController < ApplicationController
  before_action :require_login
  
  def create
    @post = current_user.posts.build post_params
    @post.wall_user ||= current_user

    if @post.save
      redirect_to root_path, flash: {error: @post.errors.full_messages.to_sentence}
    else
      redirect_back fallback_location: root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :wall_user_id)
  end
end
