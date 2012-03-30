User.create(first_name: 'Sys', last_name: 'Admin', email: 'admin@mail.com', username: 'admin', password: 'welcome', password_confirmation: 'welcome') unless User.exists?(email: 'admin@mail.com')

Priority.create(name: 'Normal') unless Priority.exists?(name: 'Normal')
Priority.create(name: 'High')   unless Priority.exists?(name: 'High')
Priority.create(name: 'Low')    unless Priority.exists?(name: 'Low')

Status.create(name: 'Pending')    unless Status.exists?(name: 'Pending')
Status.create(name: 'Open')       unless Status.exists?(name: 'Open')
Status.create(name: 'Closed')     unless Status.exists?(name: 'Closed')
Status.create(name: 'Duplicate')  unless Status.exists?(name: 'Duplicate')
Status.create(name: 'Unresolved') unless Status.exists?(name: 'Unresolved')
