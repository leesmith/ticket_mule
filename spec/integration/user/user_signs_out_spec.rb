require 'integration/integration_helper'

describe 'User signs out' do

  it 'successfully', :js do
    sign_in Fabricate(:user)
    click_link 'Sign Out'
    page.driver.browser.switch_to.alert.accept
    page.should have_content('You have successfully signed out')
    current_path.should == sign_in_path
    visit root_path
    current_path.should == sign_in_path
    page.should have_content('Please sign in before continuing')
  end

end
