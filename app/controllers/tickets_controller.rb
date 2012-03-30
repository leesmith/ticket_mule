class TicketsController < ApplicationController
  expose(:ticket)
  expose(:contacts) { Contact.select('id, first_name, last_name') }
  expose(:priorities) { Priority.select('id, name').order(:name) }
  expose(:statuses) { Status.select('id, name').order(:name) }
  expose(:groups) { Group.select('id, name').order(:name) }
  expose(:owners) { User.select('id, first_name, last_name').order(:last_name) }

  def create
    ticket.creator_id = current_user.id
    if ticket.save
      redirect_to [:tickets], flash: { success: "Ticket ##{ticket.id} was successfully created." }
    else
      render :new
    end
  end

end
