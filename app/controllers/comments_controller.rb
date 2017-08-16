class CommentsController < ApplicationController
  before_action :require_login

  def create
    current_user.comments.create comment_params
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :body)
  end
end
