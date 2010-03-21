Factory.define :user do |u|
  u.first_name 'Jack'
  u.last_name 'Daniels'
  u.username { |n| "#{n.first_name}#{n.last_name}".downcase }
  u.email { |a| "#{a.first_name}.#{a.last_name}@mail.com".downcase }
  u.email_confirmation { |c| c.email }
  u.password 'welcome1'
  u.password_confirmation 'welcome1'
  u.password_salt { Authlogic::Random.hex_token }
  u.crypted_password { |s| Authlogic::CryptoProviders::Sha512.encrypt("welcome1" + s.password_salt) }
  u.time_zone 'Central Time (US & Canada)'
end