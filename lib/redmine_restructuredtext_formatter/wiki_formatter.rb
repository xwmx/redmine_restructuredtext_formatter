require 'rbst'

module RedmineRestructuredtextFormatter
  class WikiFormatter
    def initialize(text)
      # TODO: Implement UI to config these and the CSS and store them in DB:
      @text = <<-EOD
      .. role:: underline
      .. role:: strike
      .. role:: overline
      .. role:: rtl
      .. role:: ltr
      .. role:: lre
      .. role:: rle

      .. |lre| unicode:: U+202A
         :rtrim:
      .. |rle| unicode:: U+202B
         :rtrim:
      .. |pdf| unicode:: U+202C
         :ltrim:

      EOD
      @text << text
    end

    def to_html(&block)
      # TODO: Make the the parameters configurable:
      RbST.new(@text).to_html(:language => 'en', :part => 'fragment', :tab_width => 4)
    rescue => e
      return("<br /><pre>problem parsing wiki text: #{e.message}\n"+
             "original text: \n"+
             @text+
             "</pre>")
    end
  end
end
