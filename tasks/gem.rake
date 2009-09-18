require "rake/gempackagetask"

namespace :gem do
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
    s.add_runtime_dependency("prawn", ">= 0.5.0")
    s.add_runtime_dependency("treetop", ">= 1.3.0")
    s.add_runtime_dependency("text-format", "1.0.0")

    s.require_path = "lib"

    s.author = "Virgil Dimaguila"
    s.email = "virgil@roundysoft.com"
    s.homepage = "http://virgild.github.com/resumetools"
  end

  Rake::GemPackageTask.new(GEM_SPEC) do |p|
    p.gem_spec = GEM_SPEC
    p.need_tar = true
    p.need_zip = true
  end
  
  desc "Generate gemspec file"
  task :gemspec do
    File.open(File.join(File.dirname(__FILE__), '..', 'resumetools.gemspec'), "w") do |f|
      f.write(GEM_SPEC.to_ruby)
    end
  end

  desc "Show information about the gem"
  task :debug do
    puts GEM_SPEC.to_ruby
  end

  desc "Install the gem"
  task :install => ["clobber", "gem:package"] do
    sh "#{SUDO} gem install --local pkg/#{GEM_SPEC.full_name}"
  end

  desc "Uninstall the gem"
  task :uninstall do
    installed_list = Gem.source_index.find_name(PKG_NAME)
    if installed_list &&
        (installed_list.collect { |s| s.version.to_s}.include?(PKG_VERSION))
      sh(
        "#{SUDO} gem uninstall --version '#{PKG_VERSION}' " +
        "--ignore-dependencies --executables #{PKG_NAME}"
      )
    end
  end

  desc "Reinstall the gem"
  task :reinstall => [:uninstall, :install]
end

desc "Alias to gem:package"
task "gem" => "gem:package"

task "clobber" => ["gem:clobber_package"]
