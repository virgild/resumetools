require "rake/gempackagetask"


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
  "vendor/**/*",
  "tasks/**/*",
  "fonts/**/*",
  "[A-Z]*",
  "README.md",
  "Rakefile"
].exclude(/[_\.]git$/, 'TODO')
WINDOWS = (RUBY_PLATFORM =~ /mswin|win32|mingw|bccwin|cygwin/) rescue false
SUDO = WINDOWS ? '' : ('sudo' unless ENV['SUDOLESS'])

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
    
    s.required_ruby_version = ">= 1.8.6"
    
    s.add_development_dependency("rake", ">= 0.8.7")
    s.add_development_dependency("rspec", ">= 1.2.8")
   
    s.add_runtime_dependency("extlib")
    s.add_runtime_dependency("prawn", ">= 0.7.1")
    s.add_runtime_dependency("treetop", ">= 1.3.0")
    s.add_runtime_dependency("json_pure")
    s.add_runtime_dependency("uuidtools")

    s.require_path = "lib"

    s.author = "Virgil Dimaguila"
    s.email = "virgil@roundysoft.com"
    s.homepage = "http://codaset.com/virgil/resumetools"
    s.rubyforge_project = "resumetools"
  end

  Rake::GemPackageTask.new(GEM_SPEC) do |p|
    p.gem_spec = GEM_SPEC
  end
  
  
  # Generate gemspec
  desc "Generate gemspec file"
  task :gemspec do
    File.open(File.join(File.dirname(__FILE__), '..', 'resumetools.gemspec'), "w") do |f|
      f.write(GEM_SPEC.to_ruby)
    end
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

task "clobber" => ["gem:clobber_package"]
