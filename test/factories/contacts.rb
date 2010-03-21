Factory.define :contact do |c|
  c.first_name 'Tom'
  c.last_name 'Jones'
  c.email { |a| "#{a.first_name}.#{a.last_name}@mail.com".downcase }
  c.mobile_phone Faker::PhoneNumber.phone_number
  c.office_phone Faker::PhoneNumber.phone_number
  c.affiliation Faker::Company.name
  c.notes Faker::Lorem.sentence(word_count=15)
end