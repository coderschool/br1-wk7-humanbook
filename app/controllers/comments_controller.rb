class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = current_user.comments.create comment_params

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :body)
  end
end
