class TicketObserver < ActiveRecord::Observer
  def before_validation(ticket)
    if ticket.new_record?
      ticket.status_id = Status.pending.first.id unless Status.pending.first.nil?
    end
  end
end
