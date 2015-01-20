lib_dir = File.expand_path(File.join(File.dirname(__FILE__), "lib"))
$:.unshift(lib_dir)
$:.uniq!

require 'rubygems'
require 'bundler/setup'

require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'rspec/core/rake_task'

require File.join(File.dirname(__FILE__), 'lib', 'resumetools', 'version')

Dir["tasks/**/*.rake"].each { |task| load task }
