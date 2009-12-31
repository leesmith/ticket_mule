require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    group = Group.new
    assert !group.valid?
    puts group.errors.full_messages
    assert group.errors.invalid?(:name)
  end
end
