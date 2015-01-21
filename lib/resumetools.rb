#--
# Copyright (c) 2009 Virgil Dimaguila
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#++

require 'active_support'
require 'active_support/core_ext'
require "prawn"
require "prawn/table"
require "prawn/measurement_extensions"
require "treetop"

unless defined?(Text::Format)
  require File.expand_path(File.dirname(__FILE__) + "/text/format")
end

require File.expand_path(File.dirname(__FILE__) + "/resumetools/version")
require File.expand_path(File.dirname(__FILE__) + "/resumetools/resume/resume")
require File.expand_path(File.dirname(__FILE__) + "/resumetools/resume/text_reader")
require File.expand_path(File.dirname(__FILE__) + "/resumetools/resume/pdf")
require File.expand_path(File.dirname(__FILE__) + "/resumetools/resume/plain_text")
require File.expand_path(File.dirname(__FILE__) + "/resumetools/resume/json")
require File.expand_path(File.dirname(__FILE__) + "/resumetools/resume/export")

