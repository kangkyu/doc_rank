require 'yomu'
require 'highscore'

# A gem to rank document similarities.
module DocRank
  # Document holds the contents of a document (.pdf, .docx, .txt) and has methods:
  # name, text, and weighted_keywords.
  class Document

    # [String] the name of the document.
    attr_reader :name
    # [String] the text content of the document.
    attr_reader :text
    # [Hash] a collection of keywords mapped to their weight.
    attr_reader :weighted_keywords

    # @param [String] file The path to the file.
    def initialize(file_path)
      @text = Yomu.new(file_path).text
      @name = File.basename file_path
      @weighted_keywords = Highscore::Content.new(@text).keywords.map do |kw|
        [kw.text, kw.weight]
      end.to_h
    end
  end
end
