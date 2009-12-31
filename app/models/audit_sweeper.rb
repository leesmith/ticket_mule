class AuditSweeper < ActionController::Caching::Sweeper
  observe Ticket

  def after_validation_on_update(ticket)
    if ticket.errors.blank? # do nothing if the ticket has errors
      # if updated_at is the only attribute changed (ticket was touched), skip audit comment
      unless ticket.only_touched?
        user = controller.current_user
        text = ""

        if ticket.title_changed?
          text = text + "<strong>Title</strong> changed to #{ticket.title}"
        end
        if ticket.contact_id_changed?
          text = text + "<br/>" if !text.empty?
          text = text + "<strong>Contact</strong> changed to #{ticket.contact.full_name}"
        end
        if ticket.group_id_changed?
          text = text + "<br/>" if !text.empty?
          text = text + "<strong>Group</strong> changed to #{ticket.group.name}"
        end
        if ticket.status_id_changed?
          text = text + "<br/>" if !text.empty?
          text = text + "<strong>Status</strong> changed to #{ticket.status.name}"
        end
        if ticket.owned_by_changed?
          if ticket.owned_by.nil?
            text = text + "<br/>" if !text.empty?
            text = text + "<strong>Owner</strong> removed"
          else
            text = text + "<br/>" if !text.empty?
            text = text + "<strong>Owner</strong> changed to #{ticket.owner.username}"
          end
        end
        if ticket.priority_id_changed?
          text = text + "<br/>" if !text.empty?
          text = text + "<strong>Priority</strong> changed to #{ticket.priority.name}"
        end
        if ticket.details_changed?
          text = text + "<br/>" if !text.empty?
          text = text + "<strong>Details</strong> changed"
        end

        ticket.comments.create(:user_id => user.id) do |c|
          c.comment = text
        end

        unless ticket.alert_users.blank?
          user_list = Array.new
          ticket.alert_users.each do |u|
            # don't send the email to the person making the update
            unless u.id == user.id
              user_list.push(u.email)
            end
          end
          Notifier.deliver_ticket_alert(ticket,user_list,text)
        end
      end
    end
  end

end
