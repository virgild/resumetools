Gem::Specification.new do |s|
  s.name = "resumetools"
  s.version = "1.0.1"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.require_paths = ["lib"]
  s.authors = ["Virgil Dimaguila"]
  s.date = "2015-03-16"
  s.description = "Resume generation and writing tools\n"
  s.email = "virgil@roundysoft.com"
  s.files = Dir[
      "examples/**/*",
      "lib/**/*",
      "spec/**/*",
      "tasks/**/*",
      "fonts/**/*",
      "README.md",
      "Rakefile",
      "CHANGES",
      "LICENSE"
    ]
  s.homepage = "http://virgild.github.io/resumetools"
  s.rubygems_version = "2.4.5"
  s.summary = "Resume generation and writing tools"
  s.licenses = ["MIT"]

  s.add_development_dependency('rake', '~> 10.4')
  s.add_development_dependency('rspec', '~> 3.2', '>= 3.2.0')
  s.add_runtime_dependency('activesupport', '~> 4.2', '>= 4.2.0')
  s.add_runtime_dependency('prawn', '~> 2.0', '>= 2.0.0')
  s.add_runtime_dependency('prawn-table', '~> 0.2.1')
  s.add_runtime_dependency('treetop', '~> 1.5', '>= 1.5.3')
end
