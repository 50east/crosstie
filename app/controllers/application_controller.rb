class ApplicationController < ActionController::Base
  protect_from_forgery

  def signin_user(user)
    user.track_signin!(request)

    cookies[:auth_token] = user.auth_token
  end

end
