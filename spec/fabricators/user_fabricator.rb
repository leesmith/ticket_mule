Fabricator(:user) do
  username { sequence(:username) { |i| "user#{i}" } }
  first_name 'Jim'
  last_name 'Beam'
  email { |user| "#{user.username}@mail.com" }
  password 'password'
  password_confirmation 'password'
end
