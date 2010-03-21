Factory.define :group do |g|
  g.name 'Accounting'
end

Factory.define :disabled_group, :parent => :group do |g|
  g.disabled_at Time.now
end