class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.find_by(email: params[:email])
      if user.authenticate(params[:password])
        login(user)
        flash[:success] = "Logged in!"
      else
        flash[:error] = "Invalid password."
      end
    else
      flash[:error] = "Invalid email."
    end

    redirect_to root_path
  end

  def destroy
    logout(current_user)
    redirect_to root_path, flash: {success: "Logged out."}
  end
end
