class AlertsController < ApplicationController
  before_filter :require_user

  def create
    @ticket = Ticket.find(params[:id])
    @alert = @current_user.alerts.build(:ticket_id => @ticket.id)

    respond_to do |format|
      if @current_user.has_ticket_alert?(@ticket.id) or @alert.save
        flash[:success] = 'Your alert was added and you will now receive an email any time this ticket is updated!'
        format.html { redirect_to(@ticket) }
        format.xml { render :xml => @alert, :status => :created, :location => @alert }
      else
        format.html { render 'tickets/show' }
        format.xml  { render :xml => @alert.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    # for the current_user, delete the alert with the incoming ticket id
    #alert = Alert.find_by_ticket_id_and_user_id(params[:id], @current_user.id)
    if @current_user.admin?
      alert = Alert.find(params[:id])
    else
      alert = Alert.find_by_id_and_user_id(params[:id], @current_user.id)
    end
    ticket_id = alert.ticket_id
    alert.destroy

    respond_to do |format|
      flash[:success] = "The alert for ticket ##{ticket_id} was removed!"
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end

end
