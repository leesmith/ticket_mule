Fabricator(:user) do
  username { sequence(:username) { |i| "user#{i}" } }
  email { |user| "#{user.username}@mail.com" }
  password 'password'
  password_confirmation 'password'
end
