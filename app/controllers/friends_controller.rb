class FriendsController < ApplicationController
  def my
    @users = current_user.friends
  end

  def friended_by
    @users = current_user.inverse_friends
  end
end
