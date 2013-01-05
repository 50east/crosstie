class ApiController < ApplicationController

  def success(json = {})
    render :json => { :message => 'success' }.merge(json)
  end

  def error(type = 'api_error', status = 422, json = {})
    render :status => status, :json => { :type => type }.merge(json)
  end

  def current_user
    @current_user
  end
  helper_method :current_user

  def authorize_api_token
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.where(api_token: token).first

      !@current_user.nil?
    end
  end

end
