class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def require_login
    unless current_user
      redirect_to root_path, flash: {error: "Access denied."}
    end
  end

  def login(user)
    # session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
  end

  def logout(user)
    # session[:user_id] = nil
    cookies.signed[:user_id] = nil
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end
end
