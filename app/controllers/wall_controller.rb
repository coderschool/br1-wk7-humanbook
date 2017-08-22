class WallController < ApplicationController
  def show
    @user = User.find params[:id]
    @posts = Post.where(wall_user: @user).or(Post.where(poster: @user))
  end
end
