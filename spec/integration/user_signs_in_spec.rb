require 'integration/integration_helper'

describe 'User signs in' do

  it 'successfully with email' do
    sign_in Fabricate(:user)
    current_path.should == root_path
  end

  it 'successfully with username' do
    sign_in_with_username Fabricate(:user, username: 'samadams')
    current_path.should == root_path
  end

  context 'unsuccessfully' do

    before do
      Fabricate(:user, username: 'samadams', email: 'sam@mail.com', password: 'welcome', password_confirmation: 'welcome')
      visit sign_in_path
    end
    
    it 'with empty form submission' do
      click_button 'Sign In'
      page.should have_content('Invalid credentials')
    end

    it 'with incorrect password' do
      fill_in 'User Id', with: 'samadams'
      fill_in 'Password', with: 'wrongpassword'
      click_button 'Sign In'
      page.should have_content('Invalid credentials')
      current_path.should == sessions_path
    end

    it 'incorrect email' do
      fill_in 'User Id', with: 'bobjones'
      fill_in 'Password', with: 'welcome'
      click_button 'Sign In'
      page.should have_content('Invalid credentials')
      current_path.should == sessions_path
    end

  end

end
