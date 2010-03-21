Factory.define :priority do |p|
  p.name 'Medium'
end

Factory.define :disabled_priority, :parent => :priority do |p|
  p.disabled_at Time.now
end