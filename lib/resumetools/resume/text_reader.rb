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

module ResumeTools
  module TextReader
    class ParseException < Exception
    end
    
    module ClassMethods
      require 'treetop'
      
      Treetop.load File.join(File.dirname(__FILE__), '..', 'grammars', 'resume.treetop')
      
      # Builds a new Resume instance from text
      def from_text(text)
        parser = ::ResumeParser.new
        result = parser.parse(text)
        
        if result.nil?
          raise ParseException.new(parser.failure_reason)
        end
        
        resume = ResumeTools::Resume.new
        current_section = nil
        current_period = nil
        
        result.elements.each do |element|
          case element.data_type
          when :item
            item = ::ResumeTools::Item.new(:text => element.value)
            if current_period
              current_period.add_item(item)
            elsif current_section
              current_section.add_item(item)
            end
          when :period
            current_period = ::ResumeTools::Period.new(:title => element.value)
            current_section.add_period(current_period) if current_section
          when :section
            current_period = nil # Reset period
            current_section = ::ResumeTools::Section.new(:title => element.value)
            resume.add_section(current_section)
          when :period_location
            current_period.location = element.value if current_period
          when :period_organization
            current_period.organization = element.value if current_period
          when :period_dates
            if current_period
              dates = element.value.split("to", 2).map { |d| d.strip }
              if dates.length == 1
                current_period.dtend = dates[0]
                current_period.dtstart = nil
              elsif dates.length == 2
                current_period.dtstart = dates[0]
                current_period.dtend = dates[1]
              end
            end
          when :paragraph
            current_section.para = element.value if current_section
          when :contact_name
            resume.full_name = element.value
          when :contact_telephone
            resume.telephone = element.value
          when :contact_email
            resume.email = element.value
          when :contact_address
            if resume.address1.blank?
              resume.address1 = element.value
            elsif resume.address2.blank?
              resume.address2 = element.value
            end
          when :contact_url
            resume.url = element.value
          end
        end
        
        resume
      end
    end
  end
  
  class << Resume
    include TextReader::ClassMethods
  end
end