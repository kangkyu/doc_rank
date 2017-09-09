require 'spec_helper'

RSpec.describe 'DocRank.compare' do
  files = %w(resume1.doc resume2.docx resume3.pdf)
  let(:base_doc) { "#{RSPEC_ROOT}/sample_texts/job_desc.txt" }
  let(:target_docs) { files.map{|f| "#{RSPEC_ROOT}/sample_texts/#{f}"} }

  it 'returns a hash when given a base and a single target' do
    expect(DocRank.compare(base_doc, base_doc)).to be_a(Hash)
  end

  it 'returns a hash when given a base and many targets' do
    expect(DocRank.compare(base_doc, target_docs)).to be_a(Hash)
  end

  it 'returns document names and match scores' do
    DocRank.compare(base_doc, target_docs).each do |name, score|
      expect(name).to be_a(String)
      expect(score).to be_an(Integer)
    end
  end
end
