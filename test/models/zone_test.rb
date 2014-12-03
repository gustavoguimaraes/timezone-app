require "test_helper"

class ZoneTest < ActiveSupport::TestCase

  def user
    @user ||= User.new(email: 'new@mail.com', password: 'password')
  end

  def zone
    @zone ||= user.zones.build(name: "Pacific Standard Time", city_name: "Portland, OR", minutes_offset: -7*60)
  end

  def test_valid
    assert zone.valid?
  end

  def test_name_presence
    zone.name = nil
    assert zone.invalid?
  end

  def test_city_name_presence
    zone.city_name = nil
    assert zone.invalid?
  end

  def test_minutes_offset_presence
    zone.minutes_offset = nil
    assert zone.invalid?
  end

  def test_minutes_offset_numericality
    zone.minutes_offset = "sixty"
    assert zone.invalid?
  end

  def test_belongs_to_user
    assert_equal zone.user, user
  end

end
