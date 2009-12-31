# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key => '_ticket_mule_session',
  :secret      => '48502c9f3bbe72df86b3bc3e94637f339f8f22919018511c3668afa5c7640874e96b7da60137dd1baea76f47b1f5b4b9636f07fdf3c437a547726d90faa66dd9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
