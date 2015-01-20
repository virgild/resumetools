require 'rubygems/package_task'

PKG_DISPLAY_NAME      = "resumetools"
PKG_NAME              = PKG_DISPLAY_NAME.downcase
PKG_VERSION           = ResumeTools::VERSION
PKG_FILE_NAME         = "#{PKG_NAME}-#{PKG_VERSION}"
RELEASE_NAME          = "REL #{PKG_VERSION}"
PKG_SUMMARY           = "Resume generation and writing tools"
PKG_DESCRIPTION       = <<-DESC
Resume generation and writing tools
DESC

PKG_FILES = FileList[
  "examples/**/*",
  "lib/**/*",
  "spec/**/*",
  "tasks/**/*",
  "fonts/**/*",
  "[A-Z]*",
  "README.md",
  "Rakefile"
].exclude(/[_\.]git$/, 'TODO')


namespace :gem do
  # Gem specification
  GEM_SPEC = Gem::Specification.new do |s|
    unless s.respond_to?(:add_development_dependency)
      puts "The gem spec requires a newer version of RubyGems."
      exit(1)
    end

    s.name = PKG_NAME
    s.version = PKG_VERSION
    s.summary = PKG_SUMMARY
    s.description = PKG_DESCRIPTION

    s.files = PKG_FILES.to_a

    s.has_rdoc = true

    s.required_ruby_version = ">= 2.0.0"

    s.add_development_dependency("rake", ">= 10.4.0")
    s.add_development_dependency("rspec", ">= 3.1.0")

    s.add_runtime_dependency("extlib", ">= 0.9.16")
    s.add_runtime_dependency("prawn", ">= 1.3.0")
    s.add_runtime_dependency("treetop", ">= 1.5.3")
    s.add_runtime_dependency("json_pure", ">= 1.8.2")
    s.add_runtime_dependency("uuidtools", ">= 2.1.5")

    s.require_path = "lib"

    s.author = "Virgil Dimaguila"
    s.email = "virgil@roundysoft.com"
    s.homepage = "https://github.com/virgild/resumetools"
    s.rubyforge_project = "resumetools"
  end


  Gem::PackageTask.new(GEM_SPEC) do |pkg|
    pkg.gem_spec = GEM_SPEC
  end


  # Generate gemspec
  desc "Generate gemspec file"
  task :gemspec do
    puts "Generating resumetools.gemspec..."
    File.open(File.join(File.dirname(__FILE__), '..', 'resumetools.gemspec'), "w") do |f|
      f.write(GEM_SPEC.to_ruby)
    end
    puts "...DONE."
  end


  # Clean extended file attributes
  desc "Clean Mac OS X extended file attributes"
  task :clean_attributes do
    puts "Cleaning Mac OS X extended file attributes..."
    `for i in $(ls -Rl@ | grep '^\t' | awk '{print $1}' | sort -u); do
      find . | xargs xattr -d $i 2>/dev/null;
     done
    `
    puts "...DONE"
  end

  task :package => :clean_attributes
end

desc "Alias to gem:package"
task "gem" => "gem:package"