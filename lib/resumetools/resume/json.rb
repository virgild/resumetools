require 'json/pure'

module ResumeTools
  module Renderer
    class JSON
      def initialize(resume)
        @resume = resume
      end
      
      def render(opts={})
        frame = {
          :full_name => @resume.full_name,
          :url => @resume.url,
          :email => @resume.email,
          :telephone => @resume.telephone,
          :address1 => @resume.address1,
          :address2 => @resume.address2,
          :sections => @resume.sections.map { |section| section.json_frame }
        }
        ::JSON.generate(frame)
      end
    end
    
    module JSONHelpers
      module SectionMethods
        def json_frame
          frame = {
            :title => self.title,
            :para => self.para,
            :items => self.items.map { |item| item.json_frame },
            :periods => self.periods.map { |period| period.json_frame }
          }
        end
      end
      
      module ItemMethods
        def json_frame
          frame = { :text => self.text }
        end
      end
      
      module PeriodMethods
        def json_frame
          frame = {
            :title => self.title,
            :location => self.location,
            :organization => self.organization,
            :dtstart => self.dtstart,
            :dtend => self.dtend,
            :items => self.items.map { |item| item.json_frame }
          }
        end
      end
    end
    
    module JSONMethods
      def render_json(opts={})
        renderer = JSON.new(self)
        renderer.render(opts)
      end
    end
  end
  
  Section.class_eval do
    include Renderer::JSONHelpers::SectionMethods
  end
  
  Period.class_eval do
    include Renderer::JSONHelpers::PeriodMethods
  end
  
  Item.class_eval do
    include Renderer::JSONHelpers::ItemMethods
  end
  
  Resume.class_eval do
    include Renderer::JSONMethods
  end
end