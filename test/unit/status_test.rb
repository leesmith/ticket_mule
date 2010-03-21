require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    status = Status.new
    assert !status.valid?
    #puts status.errors.full_messages
    assert status.errors.invalid?(:name)
  end

  test "should be valid" do
    status = Factory(:status)
    assert status.valid?
  end

  test "should be disabled" do
    status = Factory(:disabled_status)
    assert !status.enabled?
  end
end
