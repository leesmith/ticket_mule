$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../lib"
require 'prawn/format/version'
require 'coderay'

def process_style(document, style, content, line_number)
  content = process_substitutions(content)

  case style
  when "h1"        then h1(document, content)
  when "h2"        then h2(document, content)
  when "p"         then paragraph(document, content)
  when "fp"        then paragraph(document, content, false)
  when "ul"        then start_list(document)
  when "li"        then list_item(document, content)
  when "/ul"       then end_list(document)
  when "page"      then new_page(document)
  when "highlight" then highlight(document, content)
  when "hr"        then horiz_rule(document)
  when "center"    then center(document, content)
  else warn "unknown style #{style.inspect}"
  end

rescue Exception => err
  puts "[error occurred while processing line ##{line_number}]"
  raise
end

def process_substitutions(content)
  content.
    gsub(/%FORMAT:VERSION%/, Prawn::Format::Version::STRING).
    gsub(/%NOW%/, Time.now.utc.strftime("%e %B %Y at %H:%M UTC")).
    gsub(/%PDF\{(.*?)\}HTML\{(.*?)\}END%/, '\\2')
end

def center(document, content)
  document << "<center>#{content}</center>\n"
end

def horiz_rule(document)
  document << "<hr />\n"
end

def h1(document, content)
  document << "<h1>#{content}</h1>\n"
end

def h2(document, content)
  document << "<h2>#{content}</h2>\n"
end

def paragraph(document, content, indent=true)
  return unless content.strip.length > 0
  document << "<p class='#{indent ? 'indent' : ''}'>#{content}</p>\n"
end

def start_list(document)
  document << "<ul>\n"
end

def list_item(document, content)
  document << "<li>#{content}</li>\n"
end

def end_list(document)
  document << "</ul>\n"
end

def new_page(document)
  document << "<hr />\n"
end

def highlight(document, content)
  file, syntax = content.split(/,/)
  analyzed = CodeRay.scan(File.read(File.join(File.dirname(__FILE__), file)), syntax.to_sym)
  document << "<pre class='highlight'>#{analyzed.html}</pre>"
end

File.open("prawn-format.html", "w") do |html|
  html << "<html>\n<head>\n<style type='text/css'>#{DATA.read}</style>\n</head>"
  html << "<body>\n"
  File.open("#{File.dirname(__FILE__)}/manual.txt") do |source|
    number = 0
    source.each_line do |line|
      number += 1
      line.chomp!
      next if line.length == 0

      style, content = line.match(/^(\S+)\.\s*(.*)/)[1,2]
      process_style(html, style, content, number)
    end
  end
  html << "</body>\n</html>\n"
end

__END__
body {
  margin-left: 15%;
  margin-right: 15%;
  margin-top: 1em;
}

pre.highlight {
  background-color: #f8f8f8;
  border: 1px solid silver;
  font-family: Courier, monospace;
  font-size: 90%;
  color: #100;
  line-height: 1.1em;
  padding: 1em;
}

.highlight .af { color:#00C }
.highlight .an { color:#007 }
.highlight .av { color:#700 }
.highlight .aw { color:#C00 }
.highlight .bi { color:#509; font-weight:bold }
.highlight .c  { color:#888 }

.highlight .ch { color:#04D }
.highlight .ch .k { color:#04D }
.highlight .ch .dl { color:#039 }

.highlight .cl { color:#B06; font-weight:bold }
.highlight .co { color:#036; font-weight:bold }
.highlight .cr { color:#0A0 }
.highlight .cv { color:#369 }
.highlight .df { color:#099; font-weight:bold }
.highlight .di { color:#088; font-weight:bold }
.highlight .dl { color:black }
.highlight .do { color:#970 }
.highlight .ds { color:#D42; font-weight:bold }
.highlight .e  { color:#666; font-weight:bold }
.highlight .en { color:#800; font-weight:bold }
.highlight .er { color:#F00; background-color:#FAA }
.highlight .ex { color:#F00; font-weight:bold }
.highlight .fl { color:#60E; font-weight:bold }
.highlight .fu { color:#06B; font-weight:bold }
.highlight .gv { color:#d70; font-weight:bold }
.highlight .hx { color:#058; font-weight:bold }
.highlight .i  { color:#00D; font-weight:bold }
.highlight .ic { color:#B44; font-weight:bold }

.highlight .il { background: #eee }
.highlight .il .il { background: #ddd }
.highlight .il .il .il { background: #ccc }
.highlight .il .dl { font-weight: bold ! important; color: #888 ! important }

.highlight .in { color:#B2B; font-weight:bold }
.highlight .iv { color:#33B }
.highlight .la { color:#970; font-weight:bold }
.highlight .lv { color:#963 }
.highlight .oc { color:#40E; font-weight:bold }
.highlight .on { color:#000; font-weight:bold }
.highlight .op { }
.highlight .pc { color:#038; font-weight:bold }
.highlight .pd { color:#369; font-weight:bold }
.highlight .pp { color:#579 }
.highlight .pt { color:#339; font-weight:bold }
.highlight .r  { color:#080; font-weight:bold }

.highlight .rx { background-color:#fff0ff }
.highlight .rx .k { color:#808 }
.highlight .rx .dl { color:#404 }
.highlight .rx .mod { color:#C2C }
.highlight .rx .fu  { color:#404; font-weight: bold }

.highlight .s  { background-color:#fff0f0 }
.highlight .s  .s { background-color:#ffe0e0 }
.highlight .s  .s  .s { background-color:#ffd0d0 }
.highlight .s  .k { color:#D20 }
.highlight .s  .dl { color:#710 }

.highlight .sh { background-color:#f0fff0 }
.highlight .sh .k { color:#2B2 }
.highlight .sh .dl { color:#161 }

.highlight .sy { color:#A60 }
.highlight .sy .k { color:#A60 }
.highlight .sy .dl { color:#630 }

.highlight .ta { color:#070 }
.highlight .tf { color:#070; font-weight:bold }
.highlight .ts { color:#D70; font-weight:bold }
.highlight .ty { color:#339; font-weight:bold }
.highlight .v  { color:#036 }
.highlight .xt { color:#444 }

