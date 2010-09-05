require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    ticket = Ticket.new
    assert !ticket.valid?
    assert ticket.errors.invalid?(:title)
    assert ticket.errors.invalid?(:group_id)
    assert ticket.errors.invalid?(:status_id)
    assert ticket.errors.invalid?(:priority_id)
    assert ticket.errors.invalid?(:contact_id)
    assert ticket.errors.invalid?(:created_by)
  end

  test "valid ticket" do
    ticket = Factory.build(:ticket)
    assert ticket.valid?
  end
end
