Prawn::Document.generate('basics.pdf') do
  tags :h1 => { :font_size => "3em", :font_weight => :bold },
    :h2 => { :font_size => "2em", :font_style => :italic },
    :product => { :color => "red",
                  :text_decoration => :underline }

  text "<h1>Manual</h1>"
  text "<h2>Learning to do stuff</h2>"
  text "<product>Prawn</product> is a PDF generator for Ruby"
end
