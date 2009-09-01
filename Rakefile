lib_dir = File.expand_path(File.join(File.dirname(__FILE__), "lib"))
$:.unshift(lib_dir)
$:.uniq!

require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'spec/rake/spectask'

require File.join(File.dirname(__FILE__), 'lib', 'resumetools', 'version')

PKG_DISPLAY_NAME      = "ResumeTools"
PKG_NAME              = PKG_DISPLAY_NAME.downcase
PKG_VERSION           = ResumeTools::VERSION::STRING
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

Dir["tasks/**/*.rake"].each { |task| load task }
