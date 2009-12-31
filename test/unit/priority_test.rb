require 'test_helper'

class PriorityTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    priority = Priority.new
    assert !priority.valid?
    puts priority.errors.full_messages
    assert priority.errors.invalid?(:rank)
    assert priority.errors.invalid?(:name)
  end
end
