require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should be valid" do
    user = Factory(:user)
    assert user.valid?
  end

  test "valid full name" do
    user = Factory(:user, :first_name => 'Tom', :last_name => 'Jones')
    assert_equal 'Jones, Tom', user.full_name
  end
end
