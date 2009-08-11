require 'rubygems'
require 'treetop'
require File.join(File.dirname(__FILE__), '../lib/resumetools')

class ParserTest
  attr_reader :resume, :result, :parser
  
  def initialize
    Treetop.load File.join(File.dirname(__FILE__), "../lib/grammars/resume.treetop")
    @parser = ResumeParser.new
    @resume = File.read(File.join(File.dirname(__FILE__), "../examples/sample.resume"))
    @result = @parser.parse(@resume)
  end
  
  def show_results
    if @result.nil?
      puts "Parsing failed: #{@parser.failure_reason}"
    else
      puts @result.inspect
    end
  end
  
  def inspect
    self.class.name
  end
end

if __FILE__ == $0
  parser_test = ParserTest.new
  parser_test.show_results
end
