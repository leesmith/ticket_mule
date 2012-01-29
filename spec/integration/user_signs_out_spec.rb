require 'integration/integration_helper'

describe 'User signs out' do

  it 'successfully' do
    sign_in Fabricate(:user)
    click_link 'Sign Out'
    current_path.should == sign_in_path
    page.should have_content('You have successfully signed out')
    visit root_path
    current_path.should == sign_in_path
    page.should have_content('Please sign in before continuing')
  end
end
