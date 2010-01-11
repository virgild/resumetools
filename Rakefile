lib_dir = File.expand_path(File.join(File.dirname(__FILE__), "lib"))
$:.unshift(lib_dir)
$:.uniq!

require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'spec/rake/spectask'

require File.join(File.dirname(__FILE__), 'lib', 'resumetools', 'version')

Dir["tasks/**/*.rake"].each { |task| load task }
