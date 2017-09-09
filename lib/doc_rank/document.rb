require 'yomu'
require 'highscore'

# A gem to rank document similarities.
module DocRank
  # Document holds the contents of a document (.pdf, .docx, .txt) and has methods:
  # name, text, and keywords.
  class Document

    # [String] the name of the document.
    attr_reader :name
    # [String] the text content of the document.
    attr_reader :text
    # [Highscore::Keyword] a collection of keyword objects.
    attr_reader :keywords

    # @param [String] file The path to the file.
    def initialize(file_path)
      @text = Yomu.new(file_path).text
      @name = File.basename file_path
      @keywords = Highscore::Content.new(@text).keywords
    end
  end
end
