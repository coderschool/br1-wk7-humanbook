class PostsController < ApplicationController
  before_action :require_login, only: [:create]
  before_action :set_access_headers

  def index
    params[:per] ||= 10
    @posts = Post.order("updated_at DESC").page(params[:page]).per(params[:per])
    
    respond_to do |format|
      format.json 
    end
  end

    def show
    @post = Post.find params[:id]
    respond_to do |format|
      format.html
      format.json
    end
  end
  
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

  def paging
    params[:per] ||= 10
    @posts = Post.order("updated_at DESC").page(params[:page]).per(params[:per])
    render @posts, layout: false
  end

  private

  def post_params
    params.require(:post).permit(:body, :wall_user_id, :image)
  end

  def set_access_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
