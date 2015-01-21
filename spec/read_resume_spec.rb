require File.join(File.dirname(__FILE__), "spec_helper")

describe "Creating a resume from a text" do
  before do
    sample = File.join(File.dirname(__FILE__), '..', 'examples', 'sample.resume')
    text = File.read(sample)
    @resume = ResumeTools::Resume.from_text(text)
  end

  it "should create a resume" do
    @resume.should be_instance_of(ResumeTools::Resume)
  end

  it "should have the correct contact info" do
    @resume.full_name.should == "Thomas B. Seeker"
    @resume.address1.should == "1234 Northern Star Circle"
    @resume.address2.should == "Baltimore, MD 12345"
    @resume.telephone.should == "(410) 555-1212"
  end

  it "should have 7 sections" do
    expect(@resume.sections.length).to eq 7
  end

  it "should have sections in order" do
    @resume.sections.map { |s| s.title }.should == [
      "Career Goal",
      "Qualifications Summary",
      "Technical Skills",
      "Professional Experience",
      "Education",
      "Specialized Training",
      "Certification, Honors, and Professional Affiliations"
    ]
  end

  it "should have a paragraph in the Career Goal section" do
    @resume.sections[0].para.should_not be_blank
  end

  it "should have a paragraph in the Qualifications Summary section" do
    @resume.sections[1].para.should_not be_blank
  end

  it "should have 4 items in the Technical Skills section" do
    expect(@resume.sections[2].items.length).to eq 4
  end

  it "should have 3 periods in the Professional Experience section" do
    expect(@resume.sections[3].periods.length).to eq 3
  end

  it "should have 3 items in the Systems Engineer period" do
    expect(@resume.sections[3].periods[0].items.length).to eq 3
  end

  it "should have proper dates" do
    expect(@resume.sections[3].periods[0].dtstart).to eq "1993"
    expect(@resume.sections[3].periods[0].dtend).to eq "Present"
  end

  describe "rendering to plain text" do
    it "should render without errors" do
      resume_text = @resume.render_plain_text
    end
  end

  describe "rendering to JSON" do
    it "should render without errors" do
      resume_json = @resume.render_json
    end
  end

  describe "rendering to PDF" do
    it "should render without errors" do
      pdf_data = @resume.render_pdf
    end
  end
end