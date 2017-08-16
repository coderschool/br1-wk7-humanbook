class LikesController < ApplicationController
  before_action :require_login

  # expect parmas[:post_id] or params[:comment_id]
  def toggle
    if params[:post_id]
      post = Post.find params[:post_id]
      current_user.toggle_like!(post)
    elsif params[:comment_id]
      raise "Not yet implemented"
    end

    redirect_back fallback_location: root_path
  end
end