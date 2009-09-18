require 'rubygems'
require File.join(File.dirname(__FILE__), "../lib/resumetools")

class TextRenderTest
  attr_accessor :text, :resume
  
  def initialize
    @text = File.read(File.join(File.dirname(__FILE__), "../examples/sample.resume"))
    @resume = ResumeTools::Resume.from_text(@text)
  end
  
  def run!
    $stdout << @resume.render_plain_text
  end
end

if __FILE__ == $0
  test= TextRenderTest.new
  test.run!
end
