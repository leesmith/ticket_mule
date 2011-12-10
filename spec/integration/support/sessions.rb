require 'integration/integration_helper'

def sign_in(user)
  visit sign_in_path
  fill_in 'User Id', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign In'
end

def sign_in_with_username(user)
  visit sign_in_path
  fill_in 'User Id', with: user.username
  fill_in 'Password', with: user.password
  click_button 'Sign In'
end
