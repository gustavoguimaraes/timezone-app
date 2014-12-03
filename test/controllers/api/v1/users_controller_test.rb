require "test_helper"

class API::V1::UsersControllerTest < ActionController::TestCase

  def user
    @user ||= User.create(email: 'user@mail.com', password: 'password')
  end

  def json 
    JSON.parse response.body
  end

  # POST users
  test "POST user with valid registration has a 201 status code" do
    post :create, user: {email: 'new@mail.com', password: 'password'}
    assert_equal response.status, 201
  end

  test "POST user with valid registration has returns the authentication token" do
    post :create, user: {email: 'new@mail.com', password: 'password'}
    refute_nil json["token"]
  end

  test "POST user with invalid registration has a 400 status code" do
    post :create, user: {email: 'invalid', password: 'password'}
    assert_equal response.status, 400
    post :create, user: {email: user.email, password: user.password}
    assert_equal response.status, 400
  end

  test "POST user with invalid registration returns error messages" do
    post :create, user: {email: 'invalid', password: 'password'}
    refute_nil json["errors"]
    post :create, user: {email: user.email, password: user.password}
    refute_nil json["errors"]
  end



end
