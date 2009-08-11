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

require File.join(File.dirname(__FILE__), "spec_helper")


def resume_attributes
  { :name => "Physicist Resume",
    :title => "Physicist - 30+ yrs experience",
    :full_name => "Albert Einstein",
    :url => "http://phys6.science.org/einstein",
    :email => "albert.einstein@science.org",
    :telephone => "(555) 123-4567",
    :address1 => "221 Relativity Circle",
    :address2 => "Princeton, NJ"
  }
end

def section_attributes
  { :title => "Objectives",
    :para => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor." }
end

def period_attributes
  {
    :title => "Software Developer",
    :location => "Toronto, ON",
    :organization => "Roundysoft",
    :dtstart => Date.new(2008, 6, 15),
    :dtend => Date.new(2009, 4, 1)
  }
end

def item_attributes
  { :text => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor." }
end


describe "Resume" do
  before do
    @attributes = resume_attributes
  end
  
  it "has initial properties after creation" do
    @resume = ResumeTools::Resume.new
    @resume.name.should == "Unnamed Resume"
    @resume.title.should be_blank
    @resume.full_name.should be_blank
    @resume.has_url?.should be_false
    @resume.has_email?.should be_false
    @resume.has_telephone?.should be_false
    @resume.has_address1?.should be_false
    @resume.has_address2?.should be_false
    @resume.should have(0).sections
  end
  
  it "is created with hash properties" do
    @resume = ResumeTools::Resume.new(@attributes)
    @resume.has_url?.should be_true
    @resume.has_email?.should be_true
    @resume.has_telephone?.should be_true
    @resume.has_address1?.should be_true
    @resume.has_address2?.should be_true
    
    @resume.name.should == @attributes[:name]
    @resume.title.should == @attributes[:title]
    @resume.full_name.should == @attributes[:full_name]
    @resume.url.should == @attributes[:url]
    @resume.telephone.should == @attributes[:telephone]
    @resume.address1.should == @attributes[:address1]
    @resume.address2.should == @attributes[:address2]
    @resume.should have(0).sections
  end

end


describe "Section" do
  before(:each) do
    @resume = ResumeTools::Resume.new(resume_attributes)
    @attributes = section_attributes
  end
  
  it "is created in resume" do
    @resume.create_section do |s|
      s.title = @attributes[:title]
      s.para = @attributes[:para]
    end
    
    @resume.should have(1).sections
    section = @resume.sections[0]
    section.title.should == @attributes[:title]
    section.para.should == @attributes[:para]
  end
  
  it "should have no items" do
    section = ResumeTools::Section.new
    section.should have(0).items
  end
  
  it "should be able to add items" do
    section = ResumeTools::Section.new
    section.create_item do |item|
      item.text = "This is item A."
    end
    section.should have(1).items
    section.add_item(ResumeTools::Item.new(:text => "This is item B."))
    section.should have(2).items
    section.items[0].text.should == "This is item A."
    section.items[1].text.should == "This is item B."
  end
  
  it "is created in the right order" do
    @resume.create_section do |s|
      s.title = "First"
    end
    @resume.create_section do |s|
      s.title = "Second"
    end
    
    @resume.sections[0].title.should == "First"
    @resume.sections[1].title.should == "Second"
  end
end


describe "Period" do
  before(:each) do
    @resume = ResumeTools::Resume.new(resume_attributes)
    @resume.create_section(section_attributes)
    @section = @resume.sections[0]
    @attributes = period_attributes
  end
  
  it "is created in a section" do
    @section.create_period do |p|
      p.title = @attributes[:title]
      p.location = @attributes[:location]
      p.organization = @attributes[:organization]
      p.dtstart = @attributes[:dtstart]
      p.dtend = @attributes[:dtend]
    end
    
    @section.should have(1).periods
    period = @section.periods[0]
    period.title.should == @attributes[:title]
    period.location.should == @attributes[:location]
    period.organization.should == @attributes[:organization]
    period.dtstart.should == @attributes[:dtstart]
    period.dtend.should == @attributes[:dtend]
  end
  
  it "is added in the right order" do
    @section.create_period :title => "First"
    @section.create_period :title => "Second"
    
    @section.should have(2).periods
    @section.periods[0].title.should == "First"
    @section.periods[1].title.should == "Second"
  end
end


describe "Item" do
  before(:each) do
    @resume = ResumeTools::Resume.new(resume_attributes)
    @resume.create_section(section_attributes)
    @resume.sections[0].create_period(period_attributes)
    @period = @resume.sections[0].periods[0]
    @attributes = item_attributes
  end
  
  it "is created in a period" do
    @period.create_item do |i|
      i.text = @attributes[:text]
    end
    
    @period.should have(1).items
    item = @period.items[0]
    item.text.should == @attributes[:text]
  end
  
  it "is addd in the right order" do
    @period.create_item :text => "First"
    @period.create_item :text => "Second"
    
    @period.should have(2).items
    @period.items[0].text.should == "First"
    @period.items[1].text.should == "Second"
  end
end
