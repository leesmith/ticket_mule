# encoding: utf-8

require File.join(File.expand_path(File.dirname(__FILE__)), "spec_helper")      

describe "when parsing formatted text" do     

  before(:each) { create_pdf }

  it "should raise TagError when it does not recognize a tag" do
    parser = parser_for("<hello>")
    assert_raises(Prawn::Format::Parser::TagError) { parser.next }
  end

  it "should raise TagError when it encounters an unmatched closing tag" do
    parser = parser_for("</b>")
    assert_raises(Prawn::Format::Parser::TagError) { parser.next }
  end

  it "should raise TagError when it a tag is closed with the wrong type" do
    parser = parser_for("<b></i>")
    assert_raises(Prawn::Format::Parser::TagError) { parse(parser) }
  end

  it "should apply styles defined for tag" do
    parser = parser_for("a<b>c</b>d")
    weights = [:normal, :bold, :bold, :bold, :normal]
    assert_equal weights, parse(parser).map { |i| i.state.font_weight }
  end

  it "should honor custom tag styles" do
    parser = parser_for("a<k>c</k>d", :tags => { :k => { :text_decoration => :underline } })
    decorations = [:none, :underline, :underline, :underline, :none]
    assert_equal decorations, parse(parser).map { |i| i.state.text_decoration }
  end

  it "should honor custom style classes" do
    parser = parser_for("a<j class='test'>c</j>d", :tags => { :j => {} }, :styles => { :test => { :text_decoration => :underline } })
    decorations = [:none, :underline, :underline, :underline, :none]
    assert_equal decorations, parse(parser).map { |i| i.state.text_decoration }
  end

  it "should parse delimited text as separate instructions" do
    parser = parser_for("a b-cd")
    bits = ["a", " ", "b", "-", "cd"]
    assert_equal bits, parse(parser).map { |i| i.text }
  end

  it "should return nil after last token is parsed" do
    parser = parser_for("a")
    assert_not_nil parser.next
    assert_nil parser.next
    assert_nil parser.next
  end

  it "should report eos? at end of stream" do
    parser = parser_for("a")
    assert !parser.eos?
    parser.next
    assert parser.eos?
  end

  it "should return next instruction without consuming it when peek is called" do
    parser = parser_for("a")
    assert_equal "a", parser.peek.text
    assert !parser.eos?
    assert_equal "a", parser.next.text
    assert parser.eos?
  end

  it "should save instruction for next call when push is called" do
    parser = parser_for("a")
    k = parser.next
    assert parser.eos?
    parser.push(k)
    assert !parser.eos?
    assert_equal k, parser.next
    assert parser.eos?
  end

  it "should map meta styles to styles on the tag" do
    parser = parser_for("<k name='bob'>a</k>", :tags => { :k => { :meta => { :name => :__name__ } } })
    i = parser.next
    assert_equal "bob", i.tag[:style][:__name__]
  end

  private

    def parser_for(text, opts={})
      tags = @pdf.tags.merge(opts[:tags] || {})
      styles = @pdf.styles.merge(opts[:styles] || {})
      @parser = Prawn::Format::Parser.new(@pdf, text, opts.merge(:styles => styles, :tags => tags))
    end

    def parse(parser)
      instructions = []

      while instr = parser.next
        instructions << instr
      end

      return instructions
    end
end
