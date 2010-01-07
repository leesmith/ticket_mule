require 'prawn'
require 'prawn/format'

Prawn::Document.generate('basics.pdf') do
  text "Some <b>bold</b> and <i>italic</i> text"
end
