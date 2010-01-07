#coding: utf-8

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require "#{File.dirname(__FILE__)}/example_helper"

CHINESE_FONT = "#{Prawn::BASEDIR}/data/fonts/gkai00mp.ttf"

Prawn::Document.generate "tags.pdf" do
  # tweak an existing tag
  tags[:em][:color] = "red"
  
  # completely redefine an existing tag
  tags[:strong] = { :text_decoration => :underline }

  # define altogether new tags
  tags :chinese => { :font_family => CHINESE_FONT },
       :exp     => { :vertical_align => :super, :font_size => "70%", :color => "blue", :font_weight => :bold },
       :header  => { :font_weight => :bold, :font_size => 24, :text_decoration => :underline }

  text "<header>Fun with Tags</header>"

  text "<em>Emphasized text</em>, <strong>strong text</strong>, <chinese>汉语</chinese>, and <code>E = mc<exp>2</exp></code>"
end
