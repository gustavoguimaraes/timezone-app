require "test_helper"

class UserTest < ActiveSupport::TestCase

  def user
    @user ||= User.new(email: 'new@mail.com', password: 'password')
  end

  def test_valid
    assert user.valid?
  end

  def test_email_presence
    user.email = nil
    assert user.invalid?
  end

  def test_email_validity
    user.email = "not an email address"
    assert user.invalid?
  end

  def test_email_uniqueness
    user.dup.save
    assert user.invalid?
  end

  def test_password_presence
    user.password = nil
    assert user.invalid?
  end

  def test_access_token_presence
    user.save
    refute_nil user.access_token
  end

  def test_authentication_token
    user.save
    refute_nil user.authentication_token
  end

  def test_has_many_zones
    assert_equal user.zones, []
    refute_nil user.zones.build
  end

end
