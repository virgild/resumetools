require File.join(File.dirname(__FILE__), "spec_helper")
require "treetop"

Treetop.load File.join(File.dirname(__FILE__), "../lib/resumetools/grammars/resume.treetop")

describe "Resume Grammar" do
  before(:all) do
    resume_file = "sample.resume"
    @parser = ResumeTools::ResumeGrammarParser.new
    @resume_txt = File.read(File.join(File.dirname(__FILE__), "../examples/#{resume_file}"))
  end
  
  it "should have a parser" do
    @parser.should be_instance_of(ResumeTools::ResumeGrammarParser)
  end
  
  describe "after parsing sample file" do
    def elements_with_type(type)
      @elements.reject { |e| e.data_type != type }
    end
    
    before(:all) do
      @result = @parser.parse(@resume_txt)
      @elements = @result.elements
    end
    
    it "should parse our file" do
      @result.should_not be_nil
    end
        
    it "should have 29 items" do
      elements_with_type(:item).length.should == 29
    end
    
    it "should have 2 paragraphs" do
      elements_with_type(:paragraph).length.should == 2
    end
    
    it "should have 7 sections" do
      elements_with_type(:section).length.should == 7
    end
    
    it "should have contact name" do
      elements_with_type(:contact_name).length.should == 1
      elements_with_type(:contact_name)[0].value.should == "Thomas B. Seeker"
    end
    
    it "should have contact telephone" do
      elements_with_type(:contact_telephone).length.should == 1
      elements_with_type(:contact_telephone)[0].value.should == "(410) 555-1212"
    end
    
    it "should have contact addresses" do
      elements_with_type(:contact_address).length.should == 2
      elements_with_type(:contact_address)[0].value.should == "1234 Northern Star Circle"
      elements_with_type(:contact_address)[1].value.should == "Baltimore, MD 12345"
    end
    
    it "should have contact e-mail" do
      elements_with_type(:contact_email).length.should == 1
      elements_with_type(:contact_email)[0].value.should == "seeker@nettcom.com"
    end
    
    it "should have contact URL" do
      elements_with_type(:contact_url).length.should == 1
      elements_with_type(:contact_url)[0].value.should == "http://nettcom.com/tseeker"
    end
    
    it "should have 5 periods" do
      elements_with_type(:period).length.should == 5
    end
    
    it "should have 5 period organizations" do
      elements_with_type(:period_organization).length.should == 5
      elements_with_type(:period_organization).map { |o| o.value }.should == [
        "Computer Engineering Corporation",
        "Business Consultants, Inc.",
        "US Army Infantry",
        "Air Force Institute of Technology (AFIT)",
        "University of California, Los Angeles (UCLA)"
      ]
    end
    
    it "should have 3 period locations" do
      elements_with_type(:period_location).length.should == 3
    end
    
    it "should have 3 period dates" do
      elements_with_type(:period_dates).length.should == 3
    end
  end
  
end