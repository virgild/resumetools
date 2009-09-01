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
  module Renderer
    module PDF
      require "prawn"
      require "prawn/format"
      require "prawn/layout"
      require "prawn/measurement_extensions"
      
      FONT_DIR = File.join(File.dirname(__FILE__), '..', '..', 'fonts')
      MARGINS = [1.0, 1.0, 1.0, 1.0]
      FONT_SIZES = {
        :default => 9,
        :header => 14,
        :contact => 9,
        :section => 10,
        :para => 9,
        :item => 9,
        :period => 12
      }
      DATE_FORMAT = "%B, %Y"
      
      # Render to PDF
      def render_pdf(opts={})
        pdf = Prawn::Document.new(
          :info => {},
          :top_margin => MARGINS[0].in,
          :left_margin => MARGINS[1].in,
          :bottom_margin => MARGINS[2].in,
          :right_margin => MARGINS[3].in
        )
        
        pdf.font_families.update(
          "VeraSans" => {
            :normal => File.expand_path("Vera.ttf", FONT_DIR),
            :bold => File.expand_path("VeraBd.ttf", FONT_DIR),
            :italic => File.expand_path("VeraIt.ttf", FONT_DIR),
            :bold_italic => File.expand_path("VeraBI.ttf", FONT_DIR)
          }
        )
        
        # Set default font
        pdf.font("Helvetica", :style => :normal, :size => FONT_SIZES[:default], :kerning => true)
        
        # Name
        pdf.text self.full_name, :style => :bold, :size => FONT_SIZES[:header], :align => :center
        
        # Contact info
        pdf.text [self.address1, self.address2].join(", "), :align => :center
        pdf.text [telephone, email].join(" • "), :align => :center
        pdf.text url, :align => :center
        
        pdf.pad_bottom 20 do
        end
        
        # Sections
        self.sections.each do |section|
          pdf.pad_top(20) do
            # Section title
            pdf.text section.title, :style => :bold, :size => FONT_SIZES[:section]
            
            # Section paragraph
            unless section.para.blank?
              pdf.span(pdf.bounds.width - 10, :position => 10) do
                pdf.pad_top(5) { pdf.text section.para, :size => FONT_SIZES[:para] }
              end
            end
            
            # Section items
            unless section.items.empty?
              pdf.table section.items.map { |item| [" •", item.text] },
                :font_size => FONT_SIZES[:item],
                :column_widths => { 0 => 20, 1 => 420 },
                :border_style => :none,
                :border_color => "ffffff",
                :vertical_padding => 4,
                :horizontal_padding => 0,
                :align => { 0 => :left, 1 => :left }
            end
            
            # Periods
            section.periods.each do |period|
              pdf.span(pdf.bounds.width - 10, :position => 10) do
                pdf.pad_top(5) do
                  # Period title
                  pdf.pad_top(5) { pdf.text period.title, :style => :bold, :size => FONT_SIZES[:period] }
                  
                  # Period details
                  detail_line = []
                  dates = print_date(period.dtstart, period.dtend)
                  detail_line << period.organization unless period.organization.blank?
                  detail_line << period.location unless period.location.blank?
                  detail_line << dates unless dates.blank?
                  
                  pdf.span(pdf.bounds.width - 10, :position => 10) do
                    pdf.text(detail_line.join(" • "), :size => FONT_SIZES[:default])
                  end
                  
                  # Period items
                  unless period.items.empty?
                    pdf.table period.items.map { |item| [" •", item.text] },
                      :font_size => FONT_SIZES[:item],
                      :column_widths => { 0 => 20, 1 => 420 },
                      :border_style => :none,
                      :border_color => "ffffff",
                      :vertical_padding => 4,
                      :horizontal_padding => 0,
                      :align => { 0 => :center, 1 => :left }
                  end
                end
              end
            end
          end
        end
        
        pdf.render
      end
      
      private
      def print_date(dtstart, dtend)
        if dtstart && dtend
          dtstart + " - " + dtend
        elsif dtstart && dtend.nil?
          dtstart.strftime(DATE_FORMAT)
        else
          ""
        end
      end
    end
  end
  
  Resume.class_eval do
    include Renderer::PDF
  end
end