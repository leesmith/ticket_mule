Factory.define :ticket do |t|
  t.title Faker::Lorem.sentence(word_count=15)
  t.details Faker::Lorem.paragraphs(paragraph_count=1)
  t.association :creator, :factory => :user
  t.association :group
  t.association :status
  t.association :priority
  t.association :contact
end