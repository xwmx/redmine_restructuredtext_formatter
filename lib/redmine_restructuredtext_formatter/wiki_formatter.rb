require 'pandoc-ruby'

module RedmineRestructuredtextFormatter
  class WikiFormatter
    def initialize(text)
      @text = text
    end

    def to_html(&block)
      PandocRuby.rst(@text).to_html
    rescue => e
      return("<pre>problem parsing wiki text: #{e.message}\n"+
             "original text: \n"+
             @text+
             "</pre>")
    end
  end
end
