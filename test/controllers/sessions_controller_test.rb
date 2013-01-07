require 'minitest_helper'

describe SessionsController do
  it "authenticates a user and creates a session" do
    @user = User.create!({
      email: 'user@example.com',
      password: 'foobar',
      password_confirmation: 'foobar',
    })

    post :create, email: 'user@example.com', password: 'foobar'

    @user.reload

    cookies[:auth_token].wont_be_nil
    @user.sign_in_count.must_equal 1
    @user.last_sign_in_at.wont_be_nil
    @user.last_sign_in_ip.wont_be_nil
    response.status.must_equal 302
  end
end
