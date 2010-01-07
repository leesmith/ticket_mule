require File.join(File.expand_path(File.dirname(__FILE__)), "spec_helper")      

describe "when extending the prawn-core methods" do

  before(:each) { create_pdf }

  it "should retain proper functioning of width_of()" do
    assert_equal 28.008, @pdf.width_of("<b>hello</b>")
    assert_equal 25.344, @pdf.width_of("<b></b>hello")
  end

  it "should retain proper functioning of height_of()" do
    assert_equal @pdf.font.height*3, 
       @pdf.height_of("hi<br/><br/>there", @pdf.bounds.width)
  end

end
