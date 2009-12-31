class ContactsController < ApplicationController
  before_filter :require_user
  before_filter :lookup_contact, :only => [:show, :edit, :update, :destroy, :toggle]
  before_filter :set_current_tab
  before_filter :require_admin, :only => [:destroy, :toggle]

  def index
    unless params[:index]
      @contacts = Contact.paginate :page => params[:page], :order => 'last_name, first_name', :per_page => 10
    else
      @initial = params[:index]
      @contacts = Contact.paginate :page => params[:page], :conditions => ["last_name like ?", @initial+'%'], :order => 'last_name, first_name', :per_page => 10
    end
    @total_contacts = @contacts.total_entries
    
    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.xml  { render :xml => @contacts }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  def edit
  end

  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        flash[:success] = "#{@contact.full_name} was successfully created!"
        format.html { redirect_to(@contact) }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        flash[:success] = "#{@contact.full_name} was successfully updated!"
        format.html { redirect_to(@contact) }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end

  def toggle
    if @contact.enabled?
      @contact.disabled_at = DateTime.now
      flash_msg = "#{@contact.full_name} was successfully disabled!"
    else
      @contact.disabled_at = nil
      flash_msg = "#{@contact.full_name} was successfully enabled!"
    end

    respond_to do |format|
      if @contact.save
        flash[:success] = flash_msg
        format.html { redirect_to(@contact) }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => 'index' }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def lookup_contact
    begin
      @contact = Contact.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error(":::Attempt to access invalid contact_id => #{params[:id]}")
      flash[:error] = 'You have requested an invalid contact!'
      redirect_to contacts_path
    end
  end

  def set_current_tab
    @current_tab = :contacts
  end
end
