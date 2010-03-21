Factory.define :status do |s|
  s.name 'Open'
end

Factory.define :disabled_status, :parent => :status do |s|
  s.disabled_at Time.now
end