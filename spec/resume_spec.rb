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
  {
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

    expect(@resume.full_name).to be_blank
    expect(@resume.has_url?).to be false
    expect(@resume.has_email?).to be false
    expect(@resume.has_telephone?).to be false
    expect(@resume.has_address1?).to be false
    expect(@resume.has_address2?).to be false
    expect(@resume.has_sections?).to be false
  end

  it "is created with hash properties" do
    @resume = ResumeTools::Resume.new(@attributes)

    expect(@resume.has_url?).to be true
    expect(@resume.has_email?).to be true
    expect(@resume.has_telephone?).to be true
    expect(@resume.has_address1?).to be true
    expect(@resume.has_address2?).to be true

    expect(@resume.full_name).to eq @attributes[:full_name]
    expect(@resume.url).to eq @attributes[:url]
    expect(@resume.telephone).to eq @attributes[:telephone]
    expect(@resume.address1).to eq @attributes[:address1]
    expect(@resume.address2).to eq @attributes[:address2]
    expect(@resume.sections.length).to eq 0
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

    expect(@resume.sections.length).to eq 1
    expect(@resume.has_sections?).to be true

    section = @resume.sections[0]
    expect(section.title).to eq @attributes[:title]
    expect(section.para).to eq @attributes[:para]
  end

  it "should have no items" do
    section = ResumeTools::Section.new
    expect(section.items.length).to eq 0
    expect(section.has_items?).to be false
  end

  it "should have no periods" do
    section = ResumeTools::Section.new
    expect(section.has_periods?).to be false
  end


  it "should be able to add items" do
    section = ResumeTools::Section.new
    section.create_item do |item|
      item.text = "This is item A."
    end
    expect(section.items.length).to eq 1

    section.add_item(ResumeTools::Item.new(:text => "This is item B."))
    expect(section.items.length).to eq 2
    expect(section.items[0].text).to eq "This is item A."
    expect(section.items[1].text).to eq "This is item B."
    expect(section.has_items?).to be true
  end

  it "is created in the right order" do
    @resume.create_section do |s|
      s.title = "First"
    end
    @resume.create_section do |s|
      s.title = "Second"
    end

    expect(@resume.sections[0].title).to eq "First"
    expect(@resume.sections[1].title).to eq "Second"
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
    expect(@section.periods.length).to eq 1

    period = @section.periods[0]
    expect(period.title).to eq @attributes[:title]
    expect(period.location).to eq @attributes[:location]
    expect(period.organization).to eq @attributes[:organization]
    expect(period.dtstart).to eq @attributes[:dtstart]
    expect(period.dtend).to eq @attributes[:dtend]
  end

  it "is added in the right order" do
    @section.create_period :title => "First"
    @section.create_period :title => "Second"

    expect(@section.periods.length).to eq 2
    expect(@section.periods[0].title).to eq "First"
    expect(@section.periods[1].title).to eq "Second"
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

    expect(@period.items.length).to eq 1
    item = @period.items[0]
    expect(item.text).to eq @attributes[:text]
  end

  it "is addd in the right order" do
    @period.create_item :text => "First"
    @period.create_item :text => "Second"

    expect(@period.items.length).to eq 2
    expect(@period.items[0].text).to eq "First"
    expect(@period.items[1].text).to eq "Second"
  end
end
