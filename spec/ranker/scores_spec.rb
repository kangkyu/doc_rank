require 'spec_helper'

RSpec.describe 'DocRank::Ranker#scores' do
  let(:base) { "#{RSPEC_ROOT}/sample_texts/job_desc.txt" }
  let(:target) {[
    "#{RSPEC_ROOT}/sample_texts/resume1.doc",
  ]}
  let(:mult_targets) {[
    "#{RSPEC_ROOT}/sample_texts/resume2.docx",
    "#{RSPEC_ROOT}/sample_texts/resume3.pdf"
  ]}

  it 'returns a hash table of name and score of the target document.' do
    ranker = DocRank::Ranker.new base, target
    expect(ranker.scores).to eq({"resume1.doc"=>36})
  end

  it 'returns a hash table of name and score of multiple target documents.' do
    ranker = DocRank::Ranker.new base, mult_targets
    expect(ranker.scores).to eq({"resume3.pdf"=>32, "resume2.docx"=>11})
  end
end
