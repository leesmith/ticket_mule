require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    attachment = Attachment.new
    assert !attachment.valid?
    #puts attachment.errors.full_messages
    assert attachment.errors.invalid?(:ticket_id)
    assert attachment.errors.invalid?(:user_id)
    #assert attachment.errors.invalid?(:data_file_size)
    #assert attachment.errors.invalid?(:data_file_name)
    #assert attachment.errors.invalid?(:data_content_type)
    assert_equal 0, attachment.download_count
  end
end
