class UserSession < Authlogic::Session::Base

  # ban user after failed login limit is exceeded
  consecutive_failed_logins_limit APP_CONFIG['failed_logins_limit']

  # ban user permanently once failed login limit is exceeded
  failed_login_ban_for 0

  # logout user on session timeout
  logout_on_timeout true

end
