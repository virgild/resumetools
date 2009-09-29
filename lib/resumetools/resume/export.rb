module ResumeTools
  
  class Exporter
    def initialize(resume)
      @resume = resume
      @content = ""
    end
    
    def run
      reset!
      write_header
      blank_line
      
      @resume.sections.each_with_index do |section, n|
        write_section section
        blank_line if (n < @resume.sections.length - 1)
      end
      
      @content
    end
    
    private
    
    def reset!
      @content = ""
    end
    
    def write_header
      write_contact_info :full_name
      write_contact_info :address1
      write_contact_info :address2
      write_contact_info :telephone
      write_contact_info :email
      write_contact_info :url
    end
    
    def write_contact_info(info)
      # TODO: make this smoother
      case info
      when :full_name
        line "#N #{@resume.full_name}" unless @resume.full_name.blank?
      when :address1
        line "#A #{@resume.address1}" if @resume.has_address1?
      when :address2
        line "#A #{@resume.address2}" if @resume.has_address2?
      when :telephone
        line "#T #{@resume.telephone}" if @resume.has_telephone?
      when :email
        line "#E #{@resume.email}" if @resume.has_email?
      when :url
        line "#U #{@resume.url}" if @resume.has_url?
      end
    end
    
    def write_section(section)
      line "= #{section.title}"
      write_para(section.para) if section.has_para?
      
      section.items.each_with_index do |item, n|
        write_item item
      end
      
      section.periods.each_with_index do |period, n|
        write_period period
        blank_line if (n < section.periods.length - 1)
      end
    end
    
    def write_para(para)
      line "---"
      line para
      line "---"
    end
    
    def write_item(item)
      line "- #{item.text}"
    end
    
    def write_period(period)
      line "+ #{period.title}"
      line ">O #{period.organization}" if period.has_organization?
      line ">L #{period.location}" if period.has_location?
      write_dates(period)
      
      if period.has_items?
        period.items.each_with_index do |item, n|
          write_item item
        end
      end
    end
    
    def write_dates(period)
      text = ""
      if period.has_dtstart? && period.has_dtend?
        text = "#{period.dtstart} to #{period.dtend}"
      elsif period.has_dtstart? && !period.has_dtend?
        text = period.dtstart
      elsif !period.has_dtstart? && period.has_dtend?
        text = period.dtend
      else
        text = ""
      end
      line ">D #{text}" unless text.blank?
    end
    
    def blank_line
      @content << "\n"
    end
    
    def line(text)
      @content << text << "\n"
    end
  end
  
  module Export
    def export
      exporter = Exporter.new(self)
      exporter.run
    end
  end
  
  Resume.class_eval do
    include Export
  end
end