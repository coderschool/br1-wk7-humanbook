class HomeController < ApplicationController
  def index
    params[:per] ||= 10
    @posts = Post.order("updated_at DESC").page(params[:page]).per(params[:per])
  end
end
