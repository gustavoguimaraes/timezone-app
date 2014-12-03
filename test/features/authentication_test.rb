require "test_helper"

class AuthenticationTest < Capybara::Rails::TestCase

  def setup
    Capybara.current_driver = Capybara.javascript_driver


    @user = User.first
    @zone = @user.zones.first
  end

  test "sanity" do
    visit root_path
    assert_content page, "Timezone"
  end

  test "sign in" do
    page.execute_script("window.localStorage.clear()")
    visit root_path
    assert_content 'Password'
    page.fill_in 'email', with: @user.email
    page.fill_in 'password', with: @user.password
    click_button 'Sign in'
    refute_content 'Incorrect Email or Password'
  end

end
