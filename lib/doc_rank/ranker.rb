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
      @score ||= rank match_keywords
    end

    # Rank the target documents based on any keyword matches with the base
    #   document by summing the weights of any match.
    # @return [Hash] a hash of document names mapped to their scores.
    def weighted_scores
      @weighted_scores ||= rank match_keywords(weighted: true)
    end

  private

    def match_keywords(options = {})
      @target_docs.map do |target|
        target_kws = target.weighted_keywords
        matches = @base_kws.keys & target_kws.keys
        score = options[:weighted] ? sum_weights(matches, target_kws) : matches.count
        [target.name, score]
      end
    end

    def sum_weights(matches, target)
      matches.sum {|match| @base_kws[match] + target[match]}
    end

    def rank(docs)
      docs.sort_by{|doc| doc[1]}.to_h
    end
  end
end
