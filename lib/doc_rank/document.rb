require 'pdf/reader'
require 'docx'
module DocRank
  # Holds the contents of a a document(.pdf, .docx, .txt) as a text string.
  class Document

    # A 'getter' for the string content of the document.
    attr_reader :text

    # @param [String] file The file name.
    def initialize(file)
      @text = get_doc_content(file)
    end

    private

    # Returns the string content of a file(.pdf, .docx, .txt)
    # @param [String] file The file name.
    # @raise [ArgumentError] Throw an error when the class doesn't support a given file.
    def get_doc_content(file)
      ext = File.extname(file)
      if ext == '.pdf'
        @text = PDF::Reader.new(file).pages.map { |page| page.text }.join ' '
      elsif ext == '.docx'
        @text = Docx::Document.new(file).text
      elsif ext == '.txt'
        @text = File.read(file)
      else
        raise ArgumentError.new("File not supported.")
      end
    end
  end
end
