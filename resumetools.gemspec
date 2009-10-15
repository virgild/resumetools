# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{resumetools}
  s.version = "0.2.7.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Virgil Dimaguila"]
  s.date = %q{2009-10-15}
  s.description = %q{Resume generation and writing tools
}
  s.email = %q{virgil@roundysoft.com}
  s.files = ["examples/sample.pdf", "examples/sample.resume", "lib/fonts", "lib/fonts/Vera.ttf", "lib/fonts/VeraBd.ttf", "lib/fonts/VeraBI.ttf", "lib/fonts/VeraIt.ttf", "lib/resumetools", "lib/resumetools/grammars", "lib/resumetools/grammars/resume.treetop", "lib/resumetools/resume", "lib/resumetools/resume/export.rb", "lib/resumetools/resume/json.rb", "lib/resumetools/resume/pdf.rb", "lib/resumetools/resume/plain_text.rb", "lib/resumetools/resume/resume.rb", "lib/resumetools/resume/text_reader.rb", "lib/resumetools/version.rb", "lib/resumetools.rb", "lib/text", "lib/text/format", "lib/text/format/alpha.rb", "lib/text/format/number.rb", "lib/text/format/roman.rb", "lib/text/format.rb", "lib/text/hyphen", "lib/text/hyphen/language", "lib/text/hyphen/language/ca.rb", "lib/text/hyphen/language/cs.rb", "lib/text/hyphen/language/da.rb", "lib/text/hyphen/language/de1.rb", "lib/text/hyphen/language/de2.rb", "lib/text/hyphen/language/en_uk.rb", "lib/text/hyphen/language/en_us.rb", "lib/text/hyphen/language/es.rb", "lib/text/hyphen/language/et.rb", "lib/text/hyphen/language/eu.rb", "lib/text/hyphen/language/fi.rb", "lib/text/hyphen/language/fr.rb", "lib/text/hyphen/language/ga.rb", "lib/text/hyphen/language/hr.rb", "lib/text/hyphen/language/hsb.rb", "lib/text/hyphen/language/hu1.rb", "lib/text/hyphen/language/hu2.rb", "lib/text/hyphen/language/ia.rb", "lib/text/hyphen/language/id.rb", "lib/text/hyphen/language/is.rb", "lib/text/hyphen/language/it.rb", "lib/text/hyphen/language/la.rb", "lib/text/hyphen/language/mn.rb", "lib/text/hyphen/language/nl.rb", "lib/text/hyphen/language/no1.rb", "lib/text/hyphen/language/no2.rb", "lib/text/hyphen/language/pl.rb", "lib/text/hyphen/language/pt.rb", "lib/text/hyphen/language/sv.rb", "lib/text/hyphen/language.rb", "lib/text/hyphen.rb", "spec/grammar_spec.rb", "spec/read_resume_spec.rb", "spec/rendering_pdf_spec.rb", "spec/resume_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/default.rake", "tasks/gem.rake", "tasks/package.rake", "tasks/rdoc.rake", "tasks/rspec.rake", "CHANGES", "LICENSE", "Rakefile", "README.md"]
  s.homepage = %q{http://codaset.com/virgil/resumetools}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubyforge_project = %q{resumetools}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Resume generation and writing tools}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0.8.7"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_runtime_dependency(%q<extlib>, [">= 0"])
      s.add_runtime_dependency(%q<prawn>, [">= 0.5.1"])
      s.add_runtime_dependency(%q<treetop>, [">= 1.3.0"])
      s.add_runtime_dependency(%q<json>, [">= 1.1.9"])
    else
      s.add_dependency(%q<rake>, [">= 0.8.7"])
      s.add_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_dependency(%q<extlib>, [">= 0"])
      s.add_dependency(%q<prawn>, [">= 0.5.1"])
      s.add_dependency(%q<treetop>, [">= 1.3.0"])
      s.add_dependency(%q<json>, [">= 1.1.9"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.8.7"])
    s.add_dependency(%q<rspec>, [">= 1.2.8"])
    s.add_dependency(%q<extlib>, [">= 0"])
    s.add_dependency(%q<prawn>, [">= 0.5.1"])
    s.add_dependency(%q<treetop>, [">= 1.3.0"])
    s.add_dependency(%q<json>, [">= 1.1.9"])
  end
end
