require 'integration/integration_helper'

describe 'User signs out' do

  it 'successfully' do
    sign_in Fabricate(:user)
    click_link 'Sign out'
    current_path.should == sign_in_path
    visit root_path
    current_path.should == sign_in_path
  end
end
