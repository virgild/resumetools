namespace :spec do
  desc "Run all specs"
  RSpec::Core::RakeTask.new(:normal) do |t|
    t.pattern = FileList['spec/**/*_spec.rb']
    t.rspec_opts = ["--colour", "--format", "documentation"]
  end

  desc "Run specs with rcov"
  RSpec::Core::RakeTask.new(:rcov) do |t|
    t.pattern = FileList['spec/**/*_spec.rb']
    t.rspec_opts = ["--colour", "--format", "documentation"]
    t.rcov = true
  end
end

task :spec => "spec:normal"
