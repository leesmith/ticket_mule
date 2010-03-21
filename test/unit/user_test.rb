require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should be valid" do
    user = Factory(:user)
    assert user.valid?
  end
end
