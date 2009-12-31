class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      msg = "Welcome back <strong>#{@user_session.user.username}</strong>!"
      if @user_session.user.last_login_at
        msg = msg + "&nbsp;Your last login was on <strong>#{@user_session.user.last_login_at.strftime("%Y-%m-%d %I:%M %p")}</strong> from <strong>#{@user_session.user.last_login_ip}</strong>"
      end
      flash[:success] = msg
      redirect_back_or_default dashboard_index_path
    else
      if @user_session.being_brute_force_protected?
        flash[:error] = "User is locked: exceeded failed login limit!"
      else
        flash[:error] = "Invalid login attempt!"
      end
      redirect_to login_path
    end
  end

  def destroy
    current_user_session.destroy
    flash[:success] = "Logout successful!"
    redirect_back_or_default login_path
  end

end
