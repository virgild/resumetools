module ResumeTools
  module Renderer
    class PlainText
      def initialize(resume)
        @resume = resume
      end
      
      def render(opts={})
        @opts = {
          :item_bullet => '-',
          :header_filler => '-',
          :newline => "\n",
          :first_indent => 0,
          :columns => 80,
          :indent => 2,
          :centered_top => true,
          :lined_headers => true
        }
        @opts.merge!(opts)
        @format = Text::Format.new
        @format.first_indent = @opts[:first_indent]
        @format.columns = @opts[:columns]
        
        top_line @resume.full_name unless @resume.full_name.blank?
        top_line @resume.address1 if @resume.has_address1?
        top_line @resume.address2 if @resume.has_address2?
        top_line @resume.telephone if @resume.has_telephone?
        top_line @resume.email if @resume.has_email?
        top_line @resume.url if @resume.has_url?
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
      
      def top_line(text)
        if @opts[:centered_top]
          center text
        else
          add_line text
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
        add_line "#{@opts[:item_bullet]} " + item.text
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
        line = @opts[:newline] if line.nil?
        content << @format.center(line)
      end
      
      def add_line(line="")
        line = @opts[:newline] if line.nil?
        content << @format.format(line)
      end
      
      def blank_line
        content << @opts[:newline]
      end
      
      def push_margin(cols=0, &block)
        cols = @opts[:indent] if (cols == 0)
        previous_margin = @format.left_margin
        @format.left_margin = @format.left_margin + cols
        block.call
        @format.left_margin = previous_margin
      end
      
      def header(text)
        add_line(text)
        add_line(@opts[:header_filler] * text.length) if @opts[:lined_headers]
        blank_line
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