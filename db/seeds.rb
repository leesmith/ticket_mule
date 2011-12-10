User.create(email: 'test@mail.com', username: 'test', password: 'welcome', password_confirmation: 'welcome') unless User.exists?(email: 'test@mail.com')
