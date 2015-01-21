require 'rubygems'
require 'bundler'
Bundler.setup(:development)

require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'rspec/core/rake_task'

require File.join(File.dirname(__FILE__), 'lib', 'resumetools', 'version')

Dir["tasks/**/*.rake"].each { |task| load task }
