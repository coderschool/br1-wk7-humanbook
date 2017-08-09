class FriendshipsController < ApplicationController
  def create
    # {user_id: 1, friend_id: 2}
    current_user.friendships.create!(friendship_params)
    redirect_to users_path
  end

  # NOTE we're not using friendship id here
  def destroy
    another_user = User.find params[:user_id]
    current_user.friends.delete(another_user)
    redirect_to users_path
  end

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
