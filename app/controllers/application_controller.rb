# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user
  before_filter :set_time_zone

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '038c2ea0534ce4156b1aa41d6332e06c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password, :password_confirmation

  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    if instance.error_message.kind_of?(Array)
      %(#{html_tag}<span class="validation-error">&nbsp;#{instance.error_message.join(', ')}</span>)
    else
      %(#{html_tag}<span class="validation-error">&nbsp;#{instance.error_message}</span>)
    end
  end
  
  # get the tickets per page user preference...10 by default
  def tickets_per_page
    cookies[:tickets_per_page] || '10'
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  private

  def set_time_zone
    Time.zone = @current_user.time_zone if @current_user
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def require_user
    unless current_user
      store_location
      flash[:error] = "You must be logged in to access this page!"
      redirect_to login_path
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:error] = "You must be logged out to access this page!"
      redirect_to root_url
      return false
    end
  end

  def require_admin
    unless current_user && current_user.admin?
      store_location
      flash[:error] = "Unauthorized access!"
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] =
    if request.get?
      request.request_uri
    else
      request.referrer
    end
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
