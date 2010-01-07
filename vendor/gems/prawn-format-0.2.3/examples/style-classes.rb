#coding: utf-8

require "#{File.dirname(__FILE__)}/example_helper"

Prawn::Document.generate "style-classes.pdf" do
  styles :quote => { :font_style => :italic },
         :product => { :font_weight => :bold, :color => "#007" }

  text "<span class='product'>Prawn</span> is a fantastic utility for formatting PDF's. Jamis Buck may once have said, speaking of <span class='product'>Prawn</span>, <span class='quote'>\"<span class='product'>Prawn</span> is <em>the</em> single most fantastic PDF creation library ever to be written. In Ruby. In 2008. By Greg Brown.\"</span>"
end
