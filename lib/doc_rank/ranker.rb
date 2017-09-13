require "doc_rank/document"

# A gem to rank document similarities.
module DocRank
  # Ranker ranks documents by keywords and stores them in: scores and weighted_scores.
  class Ranker

    # [DocRank::Document] the base document.
    attr_reader :base_doc
    # [Array<DocRank::Document>] the target documents.
    attr_reader :target_docs

    # @param [String] base the file by which target documents are scored againsts.
    # @param [Array<String>] targets a single file or many files used for comparison.
    def initialize(base, targets)
      @base_doc = DocRank::Document.new base
      @base_kws = @base_doc.weighted_keywords
      @target_docs = Array(targets).map {|target| DocRank::Document.new target }
    end

    # Rank the target documents based on any keyword matches with the base
    #   document regardless of weight.
    # @return [Hash] a hash of document names mapped to their matches.
    def scores
      @score ||= begin
        results = @target_docs.map do |target|
          matches = @base_kws.keys & target.weighted_keywords.keys
          [target.name, matches.count]
        end
        rank(results)
      end
    end

    # Rank the target documents based on any keyword matches with the base
    #   document by summing the weights of any match.
    # @return [Hash] a hash of document names mapped to their scores.
    def weighted_scores
      @weighted_scores ||= begin
        results = @target_docs.map do |target|
          target_kws = target.weighted_keywords
          matches = @base_kws.keys & target_kws.keys
          [target.name, matches.sum {|match| @base_kws[match] + target_kws[match]}]
        end
        rank(results)
      end
    end

  private

    def rank(docs)
      docs.sort_by{|doc| doc[1]}.to_h
    end
  end
end
