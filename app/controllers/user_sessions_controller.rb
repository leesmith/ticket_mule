class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      #msg = "Welcome <strong>#{@user_session.user.username}</strong>!"
      msg = t('welcome_on_login', :username => @user_session.user.username)
      if @user_session.user.last_login_at
        msg = msg + "&nbsp;" + t('login_details', :timestamp => @user_session.user.last_login_at.strftime("%Y-%m-%d %I:%M %p"), :ip => @user_session.user.last_login_ip)
      end
      flash[:success] = msg
      redirect_back_or_default dashboard_index_path
    else
      if @user_session.being_brute_force_protected?
        flash[:error] = t('locked_out')
      else
        flash[:error] = t('invalid_signin')
      end
      redirect_to login_path
    end
  end

  def destroy
    current_user_session.destroy
    flash[:success] = t('logout')
    redirect_back_or_default login_path
  end

end
