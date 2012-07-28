Fabricator(:user) do
  username { sequence(:username) { |i| "user#{i}" } }
  first_name 'Jim'
  last_name 'Beam'
  email { |attrs| "#{attrs[:username]}@mail.com" }
  password 'password'
  password_confirmation 'password'
end
