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
  
  # = Resume
  # Represents a single resume document
  class Resume
    
    # The title of the resume
    attr_accessor :title
    
    # The name (or label) for this resume
    attr_accessor :name
    
    # The full name of the subject of this resume
    attr_accessor :full_name
    
    # The subject's URL
    attr_accessor :url
    
    # The subject's e-mail address
    attr_accessor :email
    
    # The subject's telephone number
    attr_accessor :telephone

    # First line of the address
    attr_accessor :address1
    
    # Second line of the address
    attr_accessor :address2
    
    # The resume's sections
    attr_reader :sections
    
    # Creates a +Resume+ and passes it to the given block. Returns the created +Resume+.
    def self.build(&block)
      resume = self.new
      yield resume
      resume
    end
    
    # Creates a new +Resume+ with the given properties
    def initialize(props={})
      @title = props[:title] || ""
      @name = props[:name] || "Unnamed Resume"
      @full_name = props[:full_name] || ""
      @url = props[:url] || ""
      @email = props[:email] || ""
      @telephone = props[:telephone] || ""
      @address1 = props[:address1] || ""
      @address2 = props[:address2] || ""
      @sections = Array.new
    end
    
    # Add section
    def add_section(section)
      self.sections << section
      self
    end
    
    # Create new section and add to sections
    def create_section(props={}, &block)
      section = Section.new(props)
      yield section if block_given?
      self.add_section(section)      
      self
    end
    
    #
    def has_url?
      !self.url.blank?
    end
    
    #
    def has_email?
      !self.email.blank?
    end
    
    #
    def has_telephone?
      !self.telephone.blank?
    end
    
    #
    def has_address1?
      !self.address1.blank?
    end
    
    #
    def has_address2?
      !self.address2.blank?
    end
    
  end
  
  
  # = Section
  # Represents a section in the resume
  class Section
    # Section title
    attr_accessor :title
    
    # Section paragraph
    attr_accessor :para
    
    # List of periods
    attr_reader :periods
    
    # List of items
    attr_reader :items
    
    #
    def initialize(props={})
      @title = props[:title] || ""
      @para = props[:para] || ""
      @items = Array.new
      @periods = Array.new
    end

    # Creates a period and adds it to the list
    def create_period(props={}, &block)
      period = Period.new(props)
      yield period if block_given?
      self.add_period(period)
      self
    end
    
    # Adds a period
    def add_period(period)
      self.periods << period
    end
    
    # Ads an item
    def add_item(item)
      self.items << item
    end
    
    # Creates an item and adds it to the list
    def create_item(props={}, &block)
      item = Item.new(props)
      yield item if block_given?
      self.add_item(item)
      self
    end
  end
  

  # = Period
  # Represents a period in the section
  class Period
    # Period title
    attr_accessor :title
    
    # Period location
    attr_accessor :location
    
    # Period organization
    attr_accessor :organization
    
    # Period start date
    attr_accessor :dtstart
    
    # Period end date
    attr_accessor :dtend
    
    # List of items
    attr_reader :items
    
    #
    def initialize(props={})
      @title = props[:title] || ""
      @location = props[:location] || ""
      @organization = props[:organization] || ""
      @dtstart = props[:dtstart] || nil
      @dtend = props[:dtend] || nil
      @items = Array.new
    end
    
    # Adds an item
    def add_item(item)
      self.items << item
    end
    
    # Creates an item and adds it to the list
    def create_item(props={}, &block)
      item = Item.new(props)
      yield item if block_given?
      self.add_item(item)
      item
    end
  end
  
  
  # = Item
  # Represents an item in a period or section. Items are usually
  # bulleted items that are listed in order
  class Item
    # The item text
    attr_accessor :text
    
    #
    def initialize(props={})
      @text = props[:text] || ""
    end
  end
  
end