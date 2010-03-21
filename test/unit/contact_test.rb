require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    contact = Contact.new
    assert !contact.valid?
    #puts contact.errors.full_messages
    assert contact.errors.invalid?(:last_name)
    assert contact.errors.invalid?(:email)
  end

  test "should be valid" do
    contact = Factory(:contact)
    assert contact.valid?
  end

  test "valid full name" do
    contact = Factory(:contact, :first_name => 'Jack', :last_name => 'Daniels')
    assert_equal 'Daniels, Jack', contact.full_name
    contact.first_name = ''
    assert_equal 'Daniels', contact.full_name
  end
end
