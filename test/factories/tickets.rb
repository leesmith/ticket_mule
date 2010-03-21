Factory.define :ticket do |t|
  t.title Faker::Lorem.sentence(word_count=15)
  t.details Faker::Lorem.paragraphs(paragraph_count=1)
end