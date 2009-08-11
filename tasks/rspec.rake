namespace :spec do
  desc "Run all specs"
  Spec::Rake::SpecTask.new(:normal) do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.spec_opts = ["--colour", "--format", "specdoc"]
  end
  
  desc "Run specs with rcov"
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.spec_opts = ["--colour", "--format", "specdoc"]
    t.rcov = true
  end
end

task :spec => "spec:normal"