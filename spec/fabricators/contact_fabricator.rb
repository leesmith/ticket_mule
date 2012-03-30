Fabricator(:contact) do
  first_name 'Sam'
  last_name 'Adams'
  email { |contact| "#{contact.first_name}.#{contact.last_name}@mail.com" }
  mobile_phone '555-555-1234'
  work_phone '555-555-0123'
  affiliation 'ACME Co.'
  notes 'Some notes about this contact.'
end
