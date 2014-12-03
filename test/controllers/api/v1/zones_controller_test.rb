require "test_helper"

class API::V1::ZonesControllerTest < ActionController::TestCase
  attr_reader :user, :other_user, :zone, :other_zone

  def setup
    @user = User.create(email: 'new@mail.com', password: 'password')
    @other_user = User.create(email: 'other@mail.com', password: 'password')
    @zone = @user.zones.create(name: "Pacific Standard Time", city_name: "Portland, OR", minutes_offset: -7*60)
    @other_zone = @other_user.zones.create(name: "GMT", city_name: "London, UK", minutes_offset: 0)
    request.env['HTTP_AUTHORIZATION'] = user.authentication_token
  end

  def json 
    JSON.parse response.body
  end

  # Authentication 
  test "GET zones with valid authentication has a 200 status code" do
    get :index
    assert_equal 200, response.status
  end

  test "GET zones with invalid authentication has a 401 status code" do
    request.env['HTTP_AUTHORIZATION'] = "bad" + user.authentication_token
    get :index
    assert_equal 401, response.status
  end

  test "GET zones with invalid authentication returns error messages" do
    request.env['HTTP_AUTHORIZATION'] = "bad" + user.authentication_token
    get :index
    refute_nil json["message"]
  end

  # GET zones
  test "GET zones with valid authentication returns all zones" do
    get :index
    assert_equal zone.id, json["zones"].first["id"]
    assert_nil json["zones"].first["created_at"]
  end

  # GET zones/:id
  test "GET zone/:id with valid authentication returns that zone" do
    get :show, id: zone.id
    assert_equal zone.id, json["zone"]["id"]
  end

  test "GET zone/:id with non-existent id has a 404 status code" do
    get :show, id: -1
    assert_equal 404, response.status
  end

  test "GET zone/:id with unauthorized resource has a 403 status code" do
    get :show, id: other_zone.id
    assert_equal 403, response.status
  end

  # PATCH zones/:id
  test "PATCH zone/:id with valid credentials has a 204 status code" do
    patch :update, id: zone.id, zone: {name: other_zone.name, city_name: other_zone.city_name, minutes_offset: other_zone.minutes_offset}
    assert_equal 204, response.status
  end

  test "PATCH zone/:id with valid credentials updates the resource" do
    patch :update, id: zone.id, zone: {name: other_zone.name, city_name: other_zone.city_name, minutes_offset: other_zone.minutes_offset}
    updated_zone = Zone.find(zone.id)
    assert_equal other_zone.name, updated_zone.name
    assert_equal other_zone.city_name, updated_zone.city_name
    assert_equal other_zone.minutes_offset, updated_zone.minutes_offset
  end

  test "PATCH zone/:id with bad parameters has a 422 status code" do
    patch :update, id: zone.id, zone: {minutes_offset: "string"}
    assert_equal 422  , response.status
  end

  test "PATCH zone/:id with bad parameters returns error messages" do
    patch :update, id: zone.id, zone: {minutes_offset: "string"}
    assert_equal "is not a number", json["errors"]["minutes_offset"][0]
  end

  # DELETE zones/:id
  test "DELETE zone/:id with valid credentials has a 204 status code" do
    delete :destroy, id: zone.id
    assert_equal 204, response.status
  end

  test "DELETE zone/:id with valid credentials destroys a zone" do
    before_count = user.zones.count
    delete :destroy, id: zone.id
    assert_equal before_count - 1, user.zones.count
  end

  test "DELETE zone/:id with invalid credentials has a 403 status code" do
    delete :destroy, id: other_zone.id
    assert_equal 403, response.status
  end

  test "DELETE zone/:id with non-existent resource has a 404 status code" do
    delete :destroy, id: -1
    assert_equal 404, response.status
  end  

  # POST zones
  test "POST zones with valid parameters returns a 201 status code" do
    post :create, zone: {name: zone.name, city_name: zone.city_name, minutes_offset: zone.minutes_offset}
    assert_equal 201, response.status
  end

  test "POST zones with valid parameters creates a new zone for the user" do
    before_count = user.zones.count
    post :create, zone: {name: zone.name, city_name: zone.city_name, minutes_offset: zone.minutes_offset}
    assert_equal before_count + 1, user.zones.count
  end

  test "POST zones with invalid parameters returns a 422 status code" do
    post :create, zone: {name: zone.name, city_name: zone.city_name, minutes_offset: "zero"}
    assert_equal 422, response.status
  end

  test "POST zones with invalid parameters does not create a new zone" do
    before_count = user.zones.count
    post :create, zone: {name: zone.name, city_name: zone.city_name, minutes_offset: "zero"}
    assert_equal before_count, user.zones.count
  end


end



