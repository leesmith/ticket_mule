# encoding: utf-8

require File.join(File.expand_path(File.dirname(__FILE__)), "spec_helper")      

def lexer_for(text)
  Prawn::Format::Lexer.new(text)
end

describe "when scanning text" do     

  it "should scan a single text word as a chunk" do
    lexer = lexer_for("christmas")
    assert_equal({ :type => :text, :text => ["christmas"] }, lexer.next)
  end

  it "should delimit multiple words by spaces" do
    lexer = lexer_for("a christmas carol by charles dickens")
    assert_equal({ :type => :text, :text => ["a", " ", "christmas", " ", "carol", " ", "by", " ", "charles", " ", "dickens"] }, lexer.next)
  end

  it "should delimit multiple words by hyphens" do
    lexer = lexer_for("christmas-carol-thingy")
    assert_equal({ :type => :text, :text => ["christmas", "-", "carol", "-", "thingy"] }, lexer.next)
  end

  it "should delimit multiple words by em-dashes" do
    lexer = lexer_for("christmas—carol—thingy")
    assert_equal({ :type => :text, :text => ["christmas", "—", "carol", "—", "thingy"] }, lexer.next)
  end

  it "should report nil as end-of-stream after scanning" do
    lexer = lexer_for("a christmas carol by charles dickens")
    assert_not_nil lexer.next
    assert_nil lexer.next
    assert_nil lexer.next
  end

end

describe "when scanning XML entities" do

  Prawn::Format::Lexer::ENTITY_MAP.each do |key, value|
    it "should map #{key} to #{value}" do
      lexer = lexer_for("&#{key};")
      assert_equal({ :type => :text, :text => [value] }, lexer.next)
    end
  end

  it "should convert decimal entities to utf-8" do
    lexer = lexer_for('&#8212;')
    assert_equal({ :type => :text, :text => ["\xe2\x80\x94"] }, lexer.next)
  end

  it "should convert hexadecimal entities to utf-8" do
    lexer = lexer_for('&#x2014;')
    assert_equal({ :type => :text, :text => ["\xe2\x80\x94"] }, lexer.next)
  end

  it "should raise InvalidFormat on unrecognized entities" do
    lexer = lexer_for('&bogus;')
    assert_raises(Prawn::Format::Lexer::InvalidFormat) do
      lexer.next
    end
  end

end

describe "when scanning tags" do

  it "should return tag with empty options for a tag with no options" do
    lexer = lexer_for("<test>")
    assert_equal({ :type => :open, :tag => :test, :options => {} }, lexer.next)
  end

  it "should scan tags with different delimiters consistently" do
    lexer = lexer_for("<test first=january second=\"february\" third='march'>")
    assert_equal({ :type => :open, :tag => :test, :options => { :first => "january", :second => "february", :third => "march" } }, lexer.next)
  end

  it "should scan closing tag" do
    lexer = lexer_for("</test>")
    assert_equal({ :type => :close, :tag => :test }, lexer.next)
  end

  it "should scan self-closing tag as two tokens" do
    lexer = lexer_for("<test/>")
    assert_equal({ :type => :open, :tag => :test, :options => {} }, lexer.next)
    assert_equal({ :type => :close, :tag => :test }, lexer.next)
  end

end
