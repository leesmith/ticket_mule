# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{prawn-format}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jamis Buck"]
  s.date = %q{2009-11-17}
  s.description = %q{an extension of Prawn that allows inline formatting}
  s.email = %q{jamis@jamisbuck.org}
  s.extra_rdoc_files = ["lib/prawn/format/effects/link.rb", "lib/prawn/format/effects/underline.rb", "lib/prawn/format/instructions/base.rb", "lib/prawn/format/instructions/tag_close.rb", "lib/prawn/format/instructions/tag_open.rb", "lib/prawn/format/instructions/text.rb", "lib/prawn/format/layout_builder.rb", "lib/prawn/format/lexer.rb", "lib/prawn/format/line.rb", "lib/prawn/format/parser.rb", "lib/prawn/format/state.rb", "lib/prawn/format/text_object.rb", "lib/prawn/format/version.rb", "lib/prawn/format.rb"]
  s.files = ["examples/basic-formatting.rb", "examples/christmas-carol.txt", "examples/document.rb", "examples/flowing.rb", "examples/style-classes.rb", "examples/syntax-highlighting.rb", "examples/tags.rb", "lib/prawn/format/effects/link.rb", "lib/prawn/format/effects/underline.rb", "lib/prawn/format/instructions/base.rb", "lib/prawn/format/instructions/tag_close.rb", "lib/prawn/format/instructions/tag_open.rb", "lib/prawn/format/instructions/text.rb", "lib/prawn/format/layout_builder.rb", "lib/prawn/format/lexer.rb", "lib/prawn/format/line.rb", "lib/prawn/format/parser.rb", "lib/prawn/format/state.rb", "lib/prawn/format/text_object.rb", "lib/prawn/format/version.rb", "lib/prawn/format.rb", "manual/html.rb", "manual/include/basics.rb", "manual/include/breaks.rb", "manual/include/custom-tags.rb", "manual/include/custom-tags2.rb", "manual/include/indent.rb", "manual/include/options.rb", "manual/include/style-classes.rb", "manual/manual.txt", "manual/pdf.rb", "Rakefile", "spec/layout_builder_spec.rb", "spec/lexer_spec.rb", "spec/parser_spec.rb", "spec/spec_helper.rb", "Manifest", "prawn-format.gemspec", "spec/extensions_spec.rb"]
  s.homepage = %q{http://rubyforge.org/projects/prawn}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Prawn-format"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{prawn}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{an extension of Prawn that allows inline formatting}
  s.test_files = ["spec/extensions_spec.rb", "spec/layout_builder_spec.rb", "spec/lexer_spec.rb", "spec/parser_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<prawn-core>, [">= 0"])
      s.add_development_dependency(%q<echoe>, [">= 0"])
    else
      s.add_dependency(%q<prawn-core>, [">= 0"])
      s.add_dependency(%q<echoe>, [">= 0"])
    end
  else
    s.add_dependency(%q<prawn-core>, [">= 0"])
    s.add_dependency(%q<echoe>, [">= 0"])
  end
end
