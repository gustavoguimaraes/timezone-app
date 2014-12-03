Given /^I am on the sign in page$/ do
  visit root_path
end

When /^I submit invalid sign in information$/ do
  click_button "Sign in"
end

Then /^I should see an error message$/ do
  expect(page).to have_text('Incorrect')
end

Given /^I have an account$/ do
  @user = User.first
end

When /^I log in as a user$/ do
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

When /^I pry$/ do
  binding.pry
end

Then(/^I should be logged in$/) do
  expect(page).to have_text "Local time"
end

When(/^I click sign out$/) do
  within ".navbar-nav" do
    click_on "Sign out"
  end
end

Then(/^I should be signed out$/) do

  expect(page).to have_text "Email"

end

