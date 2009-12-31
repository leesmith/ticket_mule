require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    contact = Contact.new
    assert !contact.valid?
    puts contact.errors.full_messages
    assert contact.errors.invalid?(:last_name)
    assert contact.errors.invalid?(:email)
  end
end
