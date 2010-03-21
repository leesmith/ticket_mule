require 'test_helper'

class PriorityTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    priority = Priority.new
    assert !priority.valid?
    #puts priority.errors.full_messages
    assert priority.errors.invalid?(:name)
  end

  test "should be valid" do
    priority = Factory(:priority)
    assert priority.valid?
  end

  test "should be disabled" do
    priority = Factory(:disabled_priority)
    assert !priority.enabled?
  end
end
