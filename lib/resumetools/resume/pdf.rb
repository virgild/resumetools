# coding: utf-8

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

      FONT_DIR = File.join(File.dirname(__FILE__), '..', '..', 'fonts')
      MARGINS = [0.75, 1.0, 0.85, 1.0]
      FONT_SIZES = {
        :default => 10,
        :header => 14,
        :contact => 10,
        :section => 11,
        :para => 10,
        :item => 10,
        :period => 10
      }
      DATE_FORMAT = "%B, %Y"

      # Render to PDF
      def render_pdf(opts={}, &blk)
        default_font = opts.delete(:default_font) || "SourceSansPro"

        pdf = Prawn::Document.new(
          :info => {},
          :top_margin => MARGINS[0].in,
          :left_margin => MARGINS[1].in,
          :bottom_margin => MARGINS[2].in,
          :right_margin => MARGINS[3].in
        )

        pdf.font_families.update(
          "SourceSansPro" => {
            :normal => File.expand_path("SourceSansPro-Regular.ttf", FONT_DIR),
            :bold => File.expand_path("SourceSansPro-Semibold.ttf", FONT_DIR),
            :italic => File.expand_path("SourceSansPro-It.ttf", FONT_DIR),
            :bold_italic => File.expand_path("SourceSansPro-SemiboldIt.ttf", FONT_DIR)
          }
        )

        # Set default font
        pdf.font(default_font, :style => :normal, :size => FONT_SIZES[:default], :kerning => true)

        # Name
        pdf.text(self.full_name, style: :bold, size: FONT_SIZES[:header], align: :center)

        # Contact info
        self.header_lines.each do |line|
          pdf.text(line, {
            align: :center
          })
        end

        pdf.pad_bottom 10 do
        end

        drawline(pdf)

        pdf.pad_bottom 0 do
        end

        # Sections
        self.sections.each_with_index do |section, index|
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
              pdf.table(section.items.map { |item| [" •", item.text] }, :cell_style => {
                :borders => []
              })
              # , cell_style: {
              #   :font_size => FONT_SIZES[:item],
              #   :border_style => :none,
              #   :border_color => "ffffff",
              #   :vertical_padding => 4,
              #   :horizontal_padding => 0,
              #   :align => { 0 => :left, 1 => :left },
              #   :column_widths => { 0 => 20, 1 => 420 }
              # }
            end

            # Periods
            section.periods.each do |period|
              pdf.pad_top(5) do
                # Period title
                pdf.pad_top(5) { pdf.text period.title, :style => :bold, :size => FONT_SIZES[:period] }

                # Period details
                pdf.pad_top(5) do
                  pdf.text(period.line, :size => FONT_SIZES[:default])
                end

                # Period items
                unless period.items.empty?
                  pdf.table(period.items.map { |item| [" •", item.text] }, :cell_style => {
                    :borders => []
                  })
                end
              end
            end
          end
        end

        if blk
          result = { pages: pdf.page_count }
          yield result
        end

        pdf.render
      end

      def drawline(pdf)
        pdf.stroke do
          pdf.line_width = 0.25
          pdf.stroke_color("000000")
          pdf.horizontal_rule
        end
      end
    end #module PDF
  end #module Renderer

  Resume.class_eval do
    include Renderer::PDF
  end
end #module ResumeTools
