require 'spec_helper'

RSpec.describe 'DocRank::Ranker#new' do
  let(:base) { "#{RSPEC_ROOT}/sample_texts/job_desc.txt" }
  let(:targets) {[
    "#{RSPEC_ROOT}/sample_texts/resume2.docx",
    "#{RSPEC_ROOT}/sample_texts/resume3.pdf"
  ]}

  it 'returns a ranker object with a base document and target documents' do
    ranker = DocRank::Ranker.new base, targets
    expect(ranker).to be_a(DocRank::Ranker)
    expect(ranker.base_doc).to be_a(DocRank::Document)
    expect(ranker.target_docs).to be_an(Array)
    ranker.target_docs.each {|target| expect(target).to be_a(DocRank::Document)}
  end
end
