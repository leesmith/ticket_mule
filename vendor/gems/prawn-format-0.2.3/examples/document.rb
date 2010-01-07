#coding: utf-8

require "#{File.dirname(__FILE__)}/example_helper.rb"

Prawn::Document.generate("document.pdf") do
  tags :h1 => { :font_size => "2em", :font_weight => :bold },
       :h2 => { :font_size => "1.5em", :font_weight => :bold },
       :stave => { :display => :break, :meta => { :name => :anchor }, :font_weight => :bold, :font_size => "2em" },
       :title => { :font_weight => :bold, :font_size => "1.5em" },
       :indent => { :width => "2em" }

  font "Times-Roman", :size => 14
  File.open("#{File.dirname(__FILE__)}/christmas-carol.txt") do |story|
    line_number = 0
    story.each_line do |line|
      line_number += 1
      next if line.strip == ""

      type, data = line.match(/^(\w+)\.\s*(.*)/)[1,2]

      case type
      when "h1"
        move_text_position 144
        text "<h1>#{data}</h1>", :align => :center
        move_text_position 72
        
      when "h2"
        text "<h2>#{data}</h2>", :align => :center
        move_text_position 72
        
      when "toc"
        bounding_box [bounds.left+bounds.width/4, y-bounds.absolute_bottom], :width => bounds.width do
          text(data)
        end

      when "stave"
        start_new_page
        text(data, :align => :center)
        move_text_position 72

      when "p"
        text("<indent/>" + data, :align => :justify)

      when "song"
        move_text_position font_size/2
        text(data, :align => :center)
        move_text_position font_size/2

      when "block"
        text(data, :align => :justify)

      when "stop"
        break

      else raise "unknown block type #{type.inspect} (line \##{line_number})"
      end
    end
  end
end
