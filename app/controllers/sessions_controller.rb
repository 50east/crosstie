class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(:email => params[:email]).first
    if user && user.authenticate(params[:password])
      signin_user(user)
      redirect_to root_path, :notice => 'You&#39;re logged in'.html_safe
    else
      flash.now[:error] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to login_path, :notice => 'You&#39;re logged out'.html_safe
  end
end
