# -*- encoding: utf-8 -*-
# stub: resumetools 0.2.8 ruby lib

Gem::Specification.new do |s|
  s.name = "resumetools"
  s.version = "0.2.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Virgil Dimaguila"]
  s.date = "2015-01-21"
  s.description = "Resume generation and writing tools\n"
  s.email = "virgil@roundysoft.com"
  s.files = ["CHANGES", "Gemfile", "Gemfile.lock", "LICENSE", "README.md", "Rakefile", "doc", "examples", "examples/sample.pdf", "examples/sample.resume", "lib", "lib/fonts", "lib/fonts/Vera.ttf", "lib/fonts/VeraBI.ttf", "lib/fonts/VeraBd.ttf", "lib/fonts/VeraIt.ttf", "lib/resumetools", "lib/resumetools.rb", "lib/resumetools/grammars", "lib/resumetools/grammars/resume.treetop", "lib/resumetools/resume", "lib/resumetools/resume/export.rb", "lib/resumetools/resume/json.rb", "lib/resumetools/resume/pdf.rb", "lib/resumetools/resume/plain_text.rb", "lib/resumetools/resume/resume.rb", "lib/resumetools/resume/text_reader.rb", "lib/resumetools/version.rb", "lib/text", "lib/text/format.rb", "pkg", "resumetools.gemspec", "script", "spec", "spec/grammar_spec.rb", "spec/read_resume_spec.rb", "spec/rendering_pdf_spec.rb", "spec/resume_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks", "tasks/default.rake", "tasks/gem.rake", "tasks/rdoc.rake", "tasks/rspec.rake", "vendor"]
  s.homepage = "http://virgild.github.io/resumetools"
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubyforge_project = "resumetools"
  s.rubygems_version = "2.4.5"
  s.summary = "Resume generation and writing tools"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 10.4.0"])
      s.add_development_dependency(%q<rspec>, [">= 3.1.0"])
      s.add_runtime_dependency(%q<extlib>, [">= 0.9.16"])
      s.add_runtime_dependency(%q<prawn>, [">= 1.3.0"])
      s.add_runtime_dependency(%q<prawn-table>, [">= 0.2.1"])
      s.add_runtime_dependency(%q<treetop>, [">= 1.5.3"])
      s.add_runtime_dependency(%q<json_pure>, [">= 1.8.2"])
      s.add_runtime_dependency(%q<uuidtools>, [">= 2.1.5"])
    else
      s.add_dependency(%q<rake>, [">= 10.4.0"])
      s.add_dependency(%q<rspec>, [">= 3.1.0"])
      s.add_dependency(%q<extlib>, [">= 0.9.16"])
      s.add_dependency(%q<prawn>, [">= 1.3.0"])
      s.add_dependency(%q<prawn-table>, [">= 0.2.1"])
      s.add_dependency(%q<treetop>, [">= 1.5.3"])
      s.add_dependency(%q<json_pure>, [">= 1.8.2"])
      s.add_dependency(%q<uuidtools>, [">= 2.1.5"])
    end
  else
    s.add_dependency(%q<rake>, [">= 10.4.0"])
    s.add_dependency(%q<rspec>, [">= 3.1.0"])
    s.add_dependency(%q<extlib>, [">= 0.9.16"])
    s.add_dependency(%q<prawn>, [">= 1.3.0"])
    s.add_dependency(%q<prawn-table>, [">= 0.2.1"])
    s.add_dependency(%q<treetop>, [">= 1.5.3"])
    s.add_dependency(%q<json_pure>, [">= 1.8.2"])
    s.add_dependency(%q<uuidtools>, [">= 2.1.5"])
  end
end
