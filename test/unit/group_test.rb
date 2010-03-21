require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    group = Group.new
    assert !group.valid?
    #puts group.errors.full_messages
    assert group.errors.invalid?(:name)
  end

  test "should be valid" do
    group = Factory(:group)
    assert group.valid?
  end

  test "should be disabled" do
    group = Factory(:disabled_group)
    assert !group.enabled?
  end
end
