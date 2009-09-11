require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe UnicodeData, '.codepoint' do
  
  include UnicodeData

  before(:all) do
    UnicodeData.build_index unless UnicodeData.valid_index?
  end

  it "returns a Codepoint object for a given Fixnum" do
    UnicodeData.codepoint(0x0384).should be_an_instance_of(Codepoint)
  end

  it "raises an ArgumentError for an unassigned codepoint" do
    lambda { UnicodeData.codepoint(0x12C1) }.should raise_error(ArgumentError)
  end
end

describe UnicodeData::Codepoint, :codepoint do
  it "returns the codepoint as a Fixnum" do
    UnicodeData.codepoint(0x1100).codepoint.should == 0x1100
  end
end


describe UnicodeData::Codepoint, :name do
  it "returns the name as a String" do
    UnicodeData.codepoint(0x16B4).name.should == "RUNIC LETTER KAUN K"
  end
end
