module DocRank
require 'pdf/reader'
require 'docx'

  class Document

    attr_reader :text

    def initialize(file)
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
