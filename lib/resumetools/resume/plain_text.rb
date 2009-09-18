require 'text/format'

module ResumeTools
  module Renderer
    class PlainText
      def initialize(resume)
        @resume = resume
      end
      
      def render(opts={})
        @item_bullet = "-"
        @header_filler = "-"
        @newline = "\n"
        @format = Text::Format.new
        @format.first_indent = 0
        @format.columns = 80
        @indent = 2
        @lined_headers = true
        
        center @resume.full_name
        center @resume.address1
        center @resume.address2
        center @resume.telephone
        center @resume.email
        center @resume.url
        blank_line

        @resume.sections.each_with_index do |section, n|
          render_section(section)
          blank_line if (n < @resume.sections.length - 1)
        end  
        content
      end
      
      private
      
      def render_section(section)
        header section.title
        render_paragraph(section.para) if section.has_paragraph?
        
        section.items.each_with_index do |item, n|
          push_margin do
            render_item(item)
          end
          blank_line if (n < section.items.length - 1)
        end
        
        section.periods.each_with_index do |period, n|
          push_margin do
            render_period period
          end
          blank_line if (n < section.periods.length - 1)
        end
      end
      
      def render_period(period)
        add_line(period.title) if period.title
        add_line period.line
        
        if period.has_items?
          blank_line
          push_margin do
            period.items.each_with_index do |item, n|
              render_item item
              blank_line if (n < period.items.length - 1)
            end
          end
        end
      end
      
      def render_item(item)
        add_line "#{@item_bullet} " + item.text
      end
      
      def render_paragraph(para)
        push_margin { add_line para }
      end
      
      def reset_content
        @text_content = String.new
      end
      
      def content
        @text_content ||= String.new
      end
      
      def center(line)
        line = @newline if line.nil?
        content << @format.center(line)        
      end
      
      def add_line(line="")
        line = @newline if line.nil?
        content << @format.format(line)
      end
      
      def blank_line
        content << @newline
      end
      
      def push_margin(cols=0, &block)
        cols = @indent if (cols == 0)
        previous_margin = @format.left_margin
        @format.left_margin = @format.left_margin + cols
        block.call
        @format.left_margin = previous_margin
      end
      
      def header(text)
        add_line(text)
        add_line(@header_filler * text.length) if @lined_headers
      end
    end #class PlainText
    
    module PlainTextMethods
      # Render to plain text
      def render_plain_text(opts={})
        renderer = PlainText.new(self)
        renderer.render(opts)
      end
    end #module Methods
    
  end #module Renderer
  
  Resume.class_eval do
    include Renderer::PlainTextMethods
  end
end #module ResumeTools