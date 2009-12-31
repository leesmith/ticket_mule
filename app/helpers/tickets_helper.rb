module TicketsHelper

  # view helper for building ticket form
  def setup_ticket(ticket)
    # fill select boxes with associated models
    @contact_select = Contact.enabled(:select => "id, first_name, last_name")
    @group_select = Group.enabled(:select => "id, name")
    @status_select = Status.enabled(:select => "id, name")
    @priority_select = Priority.enabled(:select => "id, name")
    @owner_select = User.enabled(:select => "id, username")

    unless ticket.id.blank?
      unless ticket.contact.blank? || ticket.contact.enabled?
        disabled_contact = Contact.find(ticket.contact.id)
        @contact_select.unshift(disabled_contact)
      end
      unless ticket.group.blank? || ticket.group.enabled?
        disabled_group = Group.find(ticket.group_id)
        @group_select.unshift(disabled_group)
      end
      unless ticket.status.blank? || ticket.status.enabled?
        disabled_status = Status.find(ticket.status_id)
        @status_select.unshift(disabled_status)
      end
      unless ticket.priority.blank? || ticket.priority.enabled?
        disabled_priority = Priority.find(ticket.priority_id)
        @priority_select.unshift(disabled_priority)
      end
      unless ticket.owner.blank? || ticket.owner.enabled?
        disabled_owner = User.find(ticket.owned_by)
        @owner_select.unshift(disabled_owner)
      end
    end

    # build attachment file_field and return ticket
    returning(ticket) do |t|
        t.attachments.build #if t.attachments.empty?
    end
  end

  def ticket_filter_links(status_name, user_id=nil)
    if user_id.nil?
      if status_name.downcase == 'closed'
        content_tag(:li, link_to("All Closed Tickets", tickets_path + "?search[status_id_equals]=#{@closed_status.id}"))
      else
        content_tag(:li, link_to("All Active Tickets", tickets_path))
      end
    else
      if status_name.downcase == 'closed'
        content_tag(:li, link_to("My Closed Tickets", tickets_path + "?search[status_id_equals]=#{@closed_status.id}&search[owned_by_equals]=#{user_id}"))
      else
        content_tag(:li, link_to("My Open Tickets", tickets_path + "?search[status_id_equals]=#{@open_status.id}&search[owned_by_equals]=#{user_id}"))
      end
    end
  end

end
