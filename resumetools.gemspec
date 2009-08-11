# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{resumetools}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Virgil Dimaguila"]
  s.date = %q{2009-08-10}
  s.description = %q{Resume generation and writing tools
}
  s.email = %q{virgil@roundysoft.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["examples/sample.resume", "lib/grammars", "lib/grammars/resume.treetop", "lib/resume", "lib/resume/pdf.rb", "lib/resume/resume.rb", "lib/resume/text_reader.rb", "lib/resumetools", "lib/resumetools/version.rb", "lib/resumetools.rb", "spec/grammar_spec.rb", "spec/read_resume_spec.rb", "spec/rendering_pdf_spec.rb", "spec/resume_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/default.rake", "tasks/gem.rake", "tasks/package.rake", "tasks/rdoc.rake", "tasks/rspec.rake", "CHANGES", "LICENSE", "Rakefile", "README"]
  s.homepage = %q{http://virgild.github.com/resumetools}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Resume generation and writing tools}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0.8.7"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_runtime_dependency(%q<extlib>, [">= 0"])
      s.add_runtime_dependency(%q<prawn>, [">= 0.5.0"])
      s.add_runtime_dependency(%q<treetop>, [">= 1.3.0"])
    else
      s.add_dependency(%q<rake>, [">= 0.8.7"])
      s.add_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_dependency(%q<extlib>, [">= 0"])
      s.add_dependency(%q<prawn>, [">= 0.5.0"])
      s.add_dependency(%q<treetop>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.8.7"])
    s.add_dependency(%q<rspec>, [">= 1.2.8"])
    s.add_dependency(%q<extlib>, [">= 0"])
    s.add_dependency(%q<prawn>, [">= 0.5.0"])
    s.add_dependency(%q<treetop>, [">= 1.3.0"])
  end
end