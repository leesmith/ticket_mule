class DashboardController < ApplicationController
  before_filter :require_user
  before_filter :set_current_tab

  def index
    @active_tickets = Ticket.not_closed.active_tickets
    @closed_tickets = Ticket.closed_tickets

    # create array of date strings from 30 days ago up to yesterday
    @timeline = ((Date.parse 30.days.ago.to_s)..(Date.yesterday)).inject([]){ |accum, date| accum << date.to_s }

    @timeline_opened_tickets = Ticket.timeline_opened_tickets
    @timeline_closed_tickets = Ticket.timeline_closed_tickets

    @max_opened = 0
    @max_closed = 0

    @timeline_opened_tickets.each_value do |v|
      @max_opened = v unless v <= @max_opened
    end

    @timeline_closed_tickets.each_value do |v|
      @max_closed = v unless v <= @max_closed
    end
  end

  private

  def set_current_tab
    @current_tab = :dashboard
  end

end
