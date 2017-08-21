class LikesController < ApplicationController
  before_action :require_login

  # expect parmas[:post_id] or params[:comment_id]
  def toggle
    if params[:post_id]
      @item = Post.find params[:post_id]
      current_user.toggle_like!(@item)
    elsif params[:comment_id]
      @item = Comment.find params[:comment_id]
      current_user.toggle_like!(@item)
    end

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end
  end
end
