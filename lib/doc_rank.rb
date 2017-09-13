require "doc_rank/version"
require "doc_rank/document"

# A gem to rank document similarities.
module DocRank
  # @return [Hash] a hash of document names mapped to their score.
  # @param [String] base the file by which target documents are scored againsts.
  # @param [Array<String>] targets a single file or many files used for comparison.
  def self.compare(base, targets)
    base_keywords = DocRank::Document.new(base).keywords.map(&:text)
    Array(targets).map do |target|
      doc = DocRank::Document.new target
      matches = base_keywords & doc.keywords.map(&:text)
      [doc.name, matches.size]
    end.sort_by{|doc| doc[1]}.to_h
  end

  def self.weight_compare(base, targets)
    base_keywords = DocRank::Document.new(base).keywords.to_a
    Array(targets).map do |target|
      grand_sum = 0
      doc = DocRank::Document.new target
      doc_keywords = doc.keywords.to_a
      base_keywords.each do |base_keyword|
        doc_keywords.each do |doc_keyword|
          if base_keyword.text == doc_keyword.text
            grand_sum += (base_keyword.weight + doc_keyword.weight)
          end
        end
      end
      [doc.name, grand_sum]
    end.sort_by{|doc| doc[1]}.to_h
  end
end
