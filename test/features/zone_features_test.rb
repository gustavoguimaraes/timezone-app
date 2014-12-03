require "test_helper"

class ZoneFeaturesTest < Capybara::Rails::TestCase

  def setup
    Capybara.current_driver = Capybara.javascript_driver
    @user = User.first
    @zone = @user.zones.first
    visit root_path
    page.execute_script("window.localStorage.clear()")
    visit root_path
    page.fill_in 'email', with: @user.email
    page.fill_in 'password', with: @user.password
    click_button 'Sign in'
  end

  # Capybara does clear localStorage between sessions,
  # and (incorrectly) does not consider this a bug
  def teardown
    page.execute_script("window.localStorage.clear()")
  end

  test "index" do
    assert_content 'My Timezones'
  end

end
