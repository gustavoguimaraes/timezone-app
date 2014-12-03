require "test_helper"

class API::V1::SessionsControllerTest < ActionController::TestCase

  def user
    @user ||= User.create(email: 'new@mail.com', password: 'password')
  end

  def json 
    JSON.parse response.body
  end

  # POST sessions
  test "POST sessions with valid credentials has a 201 status code" do
    post :create, user: {email: user.email, password: user.password}
    assert_equal response.status, 201
  end

  test "POST sessions with valid credentials has returns the authentication token" do
    post :create, user: {email: user.email, password: user.password}
    assert_equal json["token"], user.authentication_token
  end

  test "POST sessions with invalid credentials has a 401 status code" do
    post :create, user: {email: user.email, password: "bad" + user.password}
    assert_equal response.status, 401
  end

  test "POST sessions with invalid credentials returns error messages" do
    post :create, user: {email: user.email, password: "bad" + user.password}
    refute_nil json["message"]
  end



end
