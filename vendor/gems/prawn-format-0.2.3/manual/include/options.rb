# force unformatted display
text "Show <b>this</b> verbatim", :plain => true

# force formatted display for full justification
text "I want this to be fully justified", :plain => false,
  :align => :justify

# assume all text is blue
text "Blue text", :plain => false,
  :default_style => { :color => "blue" }

# one-off tag and style definitions
text "<nifty class='orange'>Nifty!</nifty>",
  :tags => { :nifty => { :font_weight => :bold } },
  :styles => { :orange => { :color => "#fa0" } }
