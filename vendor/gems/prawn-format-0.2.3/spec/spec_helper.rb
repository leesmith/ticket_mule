# encoding: utf-8

puts "Prawn-Format specs: Running on Ruby Version: #{RUBY_VERSION}"

require "rubygems"
require "test/spec"                                                
require "mocha"

$LOAD_PATH.unshift( ENV["PRAWN_CORE_LIB"] ||
                File.join(File.dirname(__FILE__), *%w[.. vendor prawn-core lib]) )
require "prawn/core"

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib') 
require "prawn/format"

Prawn.debug = true

$LOAD_PATH << File.join(Prawn::BASEDIR, 'vendor','pdf-inspector','lib')
gem 'pdf-reader', ">=0.7.3"
require "pdf/reader"          
require "pdf/inspector"

def create_pdf(klass=Prawn::Document)
  @pdf = klass.new(:left_margin   => 0,
                   :right_margin  => 0,
                   :top_margin    => 0,
                   :bottom_margin => 0)
end    
