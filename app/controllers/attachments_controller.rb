class AttachmentsController < ApplicationController
  before_filter :require_user
  before_filter :set_current_tab
  before_filter :require_admin, :only => [:destroy]

  def show
    attachment = Attachment.find(params[:id])
    Attachment.increment_counter(:download_count, attachment.id)

    #x_sendfile only available on Apache2 w/ mod_xsendfile or Lighttpd
    if Rails.env.production?
      send_file attachment.data.path, :type => attachment.content_type, :x_sendfile => true
    else
      send_file attachment.data.path, :type => attachment.content_type
    end
  end

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @attachment = @ticket.attachments.build(params[:attachment])
    @attachment.user_id = @current_user.id

    redirect_to(@ticket) and return if @attachment.name.blank?

    respond_to do |format|
      if @attachment.save
        flash[:success] = 'Your attachment was successfully added!'
        format.html { redirect_to(@ticket) }
        format.xml { render :xml => @attachment, :status => :created, :location => @attachment }
      else
        format.html { render 'tickets/show' }
        format.xml  { render :xml => @attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    attachment = Attachment.find(params[:id])
    ticket_id = attachment.ticket_id
    attachment.destroy

    respond_to do |format|
      flash[:success] = 'Attachment was successfully deleted!'
      format.html { redirect_to(ticket_path(ticket_id)) }
      format.xml  { head :ok }
    end
  end

  private

  def set_current_tab
    @current_tab = :tickets
  end
end
