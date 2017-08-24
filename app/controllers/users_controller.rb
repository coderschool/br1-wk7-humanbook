class UsersController < ApplicationController
  before_action :require_login, only: [:index]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      login(@user)
      redirect_to root_path, flash: {success: "User created."}
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update(user_params)
    redirect_to root_path
  end

  def index
    @users = User.all.order("created_at DESC")
  end

  def search
    @users = User.autocomplete(params[:q])
    respond_to do |format|
      format.json
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :gender, :password_confirmation, :avatar)
  end
end
