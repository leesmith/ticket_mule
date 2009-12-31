require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    status = Status.new
    assert !status.valid?
    puts status.errors.full_messages
    assert status.errors.invalid?(:name)
  end
end
