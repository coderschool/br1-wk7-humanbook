class FriendsController < ApplicationController
  def my
    @users = current_user.friends
  end

  def friended_by
    @users = current_user.inverse_friends
  end

  def search

    @friends = current_user.
      friends.where('name ILIKE ?', "#{params[:name]}%")
    
    respond_to do |format| 
      format.json
    end
  end
end
