class AdminController < ApplicationController
  before_filter :require_admin, :set_current_tab, :get_lists

  def index
  end

  def add_group
    @group = Group.new(params[:group])
    redirect_to admin_index_path and return if @group.name.blank?

    respond_to do |format|
      if @group.save
        flash[:success] = "Group #{@group.name} was successfully created!"
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
        flash[:success] = "Status #{@status.name} was successfully created!"
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
        flash[:success] = "Priority #{@priority.name} was successfully created!"
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
        flash[:success] = "User #{@user.username} was successfully created!"
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
      flash_msg = "Group #{@group.name} was successfully disabled!"
    else
      @group.disabled_at = nil
      flash_msg = "Group #{@group.name} was successfully enabled!"
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
      flash_msg = "Status #{@status.name} was successfully disabled!"
    else
      @status.disabled_at = nil
      flash_msg = "Status #{@status.name} was successfully enabled!"
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
      flash_msg = "Priority #{@priority.name} was successfully disabled!"
    else
      @priority.disabled_at = nil
      flash_msg = "Priority #{@priority.name} was successfully enabled!"
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
