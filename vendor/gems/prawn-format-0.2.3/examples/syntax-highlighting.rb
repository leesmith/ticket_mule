#coding: utf-8

require "#{File.dirname(__FILE__)}/example_helper"

begin
  require 'coderay'
rescue LoadError
  abort "This example (#{__FILE__}) requires the 'coderay' gem.\n" +
    "Please make sure it is installed."
end

# Use CodeRay to parse the source and return HTML
html = CodeRay.scan(File.read(__FILE__), :ruby).html(:line_numbers => :inline)

# Use prawn and prawn/format to parse and format the HTML
Prawn::Document.generate "syntax-highlighting.pdf", :page_layout => :landscape do
  styles :no  => { :color => "gray" },
         :c   => { :color => "#666" },
         :s   => { :color => "#d20" },
         :dl  => { :color => "black" },
         :co  => { :color => "#036", :font_weight => :bold },
         :pc  => { :color => "#038", :font_weight => :bold },
         :sy  => { :color => "#A60" },
         :r   => { :color => "#080" },
         :i   => { :color => "#00D", :font_weight => :bold },
         :idl => { :color => "#888", :font_weight => :bold }

  text "<pre>#{html}</pre>"
end
