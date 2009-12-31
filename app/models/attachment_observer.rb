class AttachmentObserver < ActiveRecord::Observer

  def after_create(attachment)
    ticket = attachment.ticket
    ticket.comments.create(:user_id => attachment.user.id) do |c|
      c.comment = "<strong>Attached</strong> #{attachment.name} #{attachment.nice_file_size}"
    end
  end

  def after_destroy(attachment)
    attachment.logger.info "::::::::::::::Deleted #{attachment.name}"
  end

end
