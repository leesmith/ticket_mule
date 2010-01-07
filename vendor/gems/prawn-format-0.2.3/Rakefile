require './lib/prawn/format/version'

begin
  require 'echoe'
rescue LoadError
  abort "You'll need to have `echoe' installed to use Prawn::Format's Rakefile"
end

version = Prawn::Format::VERSION.dup
if ENV['SNAPSHOT'].to_i == 1
  version << "." << Time.now.utc.strftime("%Y%m%d%H%M%S")
end

Echoe.new('prawn-format', version) do |p|
  p.changelog        = "CHANGELOG.rdoc"

  p.author           = "Jamis Buck"
  p.email            = "jamis@jamisbuck.org"
  p.summary          = "an extension of Prawn that allows inline formatting"
  p.url              = "http://rubyforge.org/projects/prawn"
  p.project          = "prawn"

  p.runtime_dependencies << "prawn-core"

  p.need_zip         = true
  p.include_rakefile = true

  p.rdoc_pattern     = /^(lib|README.rdoc|CHANGELOG.rdoc|THANKS.rdoc)/
  p.test_pattern     = "spec/*_spec.rb"
end
