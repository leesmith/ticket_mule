class AdminController < ApplicationController
  before_filter :require_admin, :set_current_tab, :get_lists

  def index
  end

  def add_group
    @group = Group.new(params[:group])
    redirect_to admin_index_path and return if @group.name.blank?

    respond_to do |format|
      if @group.save
        flash[:success] = t 'group_x_successfully_created', :group => @group.name
        format.html { redirect_to admin_index_path }
      else
        #set initial tab to display errors...must match tab position in index view
        @initial_tab_index = 0
        format.html { render :action => 'index' }
      end
    end
  end

  def add_status
    @status = Status.new(params[:status])
    redirect_to admin_index_path and return if @status.name.blank?

    respond_to do |format|
      if @status.save
        flash[:success] = t 'status_x_successfully_created', :status => @status.name
        format.html { redirect_to admin_index_path }
      else
        #set initial tab to display errors...must match tab position in index view
        @initial_tab_index = 1
        format.html { render :action => 'index' }
      end
    end
  end

  def add_priority
    @priority = Priority.new(params[:priority])
    redirect_to admin_index_path and return if @priority.name.blank?

    respond_to do |format|
      if @priority.save
        flash[:success] = t 'priority_x_successfully_created', :priority => @priority.name
        format.html { redirect_to admin_index_path }
      else
        #set initial tab to display errors...must match tab position in index view
        @initial_tab_index = 2
        format.html { render :action => 'index' }
      end
    end
  end

  def add_user
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:success] = t 'user_x_successfully_created', :user => @user.username
        format.html { redirect_to admin_index_path }
      else
        #set initial tab to display errors...must match tab position in index view
        @initial_tab_index = 3
        format.html { render :action => 'index' }
      end
    end
  end

  def toggle_group
    @group = Group.find(params[:id])

    if @group.enabled?
      @group.disabled_at = DateTime.now
      flash_msg = t 'group_x_successfully_disabled', :group => @group.name
    else
      @group.disabled_at = nil
      flash_msg = t 'group_x_successfully_enabled', :group => @group.name
    end

    respond_to do |format|
      if @group.save
        flash[:success] = flash_msg
        format.html { redirect_to admin_index_path }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => 'index' }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def toggle_status
    @status = Status.find(params[:id])

    if @status.enabled?
      @status.disabled_at = DateTime.now
      flash_msg = t 'status_x_successfully_disabled', :status => @status.name
    else
      @status.disabled_at = nil
      flash_msg = t 'status_x_successfully_enabled', :status => @status.name
    end

    respond_to do |format|
      if @status.save
        flash[:success] = flash_msg
        format.html { redirect_to admin_index_path }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
      else
        format.html { render :action => 'index' }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  def toggle_priority
    @priority = Priority.find(params[:id])

    if @priority.enabled?
      @priority.disabled_at = DateTime.now
      flash_msg = t 'priotity_x_successfully_disabled', :priority => @priority.name
    else
      @priority.disabled_at = nil
      flash_msg = t 'priority_x_successfully_enabled', :priority => @priority.name
    end

    respond_to do |format|
      if @priority.save
        flash[:success] = flash_msg
        format.html { redirect_to admin_index_path }
        format.xml  { render :xml => @priority, :status => :created, :location => @priority }
      else
        format.html { render :action => 'index' }
        format.xml  { render :xml => @priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def set_current_tab
    @current_tab = :admin
  end

  def get_lists
    @groups_enabled = Group.enabled
    @groups_disabled = Group.disabled
    @statuses_enabled = Status.enabled
    @statuses_disabled = Status.disabled
    @priorities_enabled = Priority.enabled
    @priorities_disabled = Priority.disabled
  end

end
