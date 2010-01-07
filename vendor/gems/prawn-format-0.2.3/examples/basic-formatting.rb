#coding: utf-8

require "#{File.dirname(__FILE__)}/example_helper.rb"

JAPANESE = "#{Prawn::BASEDIR}/data/fonts/gkai00mp.ttf"

Prawn::Document.generate "basic-formatting.pdf" do
  text "<a name='top'/>Thanks to the Prawn-Format library, <a href='#prawn'>Prawn</a> now supports <i>inline formatting</i>. What this means in practical terms is that you can embed XML tags in your text calls, turning bits like <code>&lt;b&gt;bold&lt;/b&gt;</code> into <b>bold</b>."

  move_text_position font_size

  text "Most common HTML tags are supported, including <i>&lt;i&gt;</i>, <b>&lt;b&gt;</b>, <u>&lt;u&gt;</u>, <code>&lt;code&gt;</code>, <sub>&lt;sub&gt;</sub> and <sup>&lt;sup&gt;</sup>. (For the full list, refer to <code>Prawn::Format::DEFAULT_TAGS</code> in <code>prawn/format.rb</code>.)"

  move_text_position font_size

  bounding_box [bounds.left + 72, y - bounds.absolute_bottom], :width => bounds.width - 144 do
    text "Finally, and as demonstrated by this very paragraph, Prawn-Format also supports full-justification of text. All you need to do is set <code>:align =&gt; :justify</code> in your text options, and the rest is taken care of. No more ragged right! Enter a new era of professional-looking documents.", :align => :justify
  end

  start_new_page

  text "<a name='prawn'/><font color='#f70'><strong>Prawn</strong></font> is a PDF generation library for <a href='#ruby'>Ruby</a>. Its emphasis is on speed, but also provides a very easy-to-use API, and boasts such advanced features as <em>True-Type font embedding</em>, <em>font subsetting</em>, <em>image support</em>, and many text layout functions."

  move_text_position font_size

  text "<a href='#top'>Return to top of document</a>"

  start_new_page

  text "<a name='ruby'/><font color='red'><strong>Ruby</strong></font> is a programming language with an emphasis on programmer happiness. It was developed by Yukihiro Matsumoto (<font face='#{JAPANESE}'>まつもとゆきひろ</font>, a.k.a. <strong>Matz</strong>)."

  move_text_position font_size

  text "<a href='#top'>Return to top of document</a>"
end
