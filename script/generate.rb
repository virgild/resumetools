require 'rubygems'
require 'resumetools'

samplefile = File.join(File.dirname(__FILE__), '../examples/sample.resume')
resume = ResumeTools::Resume.from_text(File.read(samplefile))
File.open("sample.pdf", "w") do |f|
  f.write(resume.render_pdf)
end
`open sample.pdf`