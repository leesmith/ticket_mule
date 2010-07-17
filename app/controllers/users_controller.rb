class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :index, :edit, :update]
  before_filter :require_admin, :only => [:destroy, :unlock]
  before_filter :lookup_user, :only => [:show, :destroy, :toggle, :unlock]
  before_filter :set_current_tab

  def new
    @user = User.new
    render :layout => 'user_sessions'
  end

  def index
    unless params[:index]
      @users = User.paginate :page => params[:page], :order => 'last_name, first_name', :per_page => 10
    else
      @initial = params[:index]
      @users = User.paginate :page => params[:page], :conditions => ["last_name like ?", @initial+'%'], :order => 'last_name, first_name', :per_page => 10
    end
    @total_users = @users.total_entries

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.xml  { render :xml => @users }
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = 'Account created successfully!'
      redirect_back_or_default dashboard_index_path
    else
      render :action => :new, :layout => 'user_sessions'
    end
  end

  def show
    @recently_assigned_to = Ticket.recently_assigned_to(@user.id)

    respond_to do |format|
      format.html #show.html.erb
      format.xml { render :xml => @user }
    end
  end

  def edit
    if @current_user.admin?
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end

  def update
    if @current_user.admin?
      @user = lookup_user
    else
      @user = @current_user
    end

    if @user.update_attributes(params[:user])
      flash[:success] = 'Account updated successfully!'
      redirect_to user_path(@user.id)
    else
      render :action => :edit
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def toggle
    if @user.enabled?
      @user.disabled_at = DateTime.now
      flash_msg = "#{@user.username} was successfully disabled!"
    else
      @user.disabled_at = nil
      flash_msg = "#{@user.username} was successfully enabled!"
    end

    respond_to do |format|
      if @user.save
        flash[:success] = flash_msg
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def unlock
    if @user.locked?
      @user.failed_login_count = nil
    end

    respond_to do |format|
      if @user.save
        flash[:success] = "#{@user.username} was successfully unlocked!"
        format.html { redirect_to @user }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def lookup_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error(":::Attempt to access invalid user_id => #{params[:id]}")
      flash[:error] = 'You have requested an invalid user!'
      redirect_to users_path
    end
  end

  def set_current_tab
    @current_tab = :users
  end
  
end
