class FriendshipsController < ApplicationController
  # expect params[:friend_id]
  def create
    current_user.friendships.create!(friendship_params)
    redirect_to users_path
  end

  # NOTE we're not using friendship id here
  # expect params[:user_id]
  def destroy
    another_user = User.find params[:user_id]
    current_user.friends.delete(another_user)
    redirect_to users_path
  end

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
