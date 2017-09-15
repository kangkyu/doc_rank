require 'spec_helper'

RSpec.describe 'DocRank::Document#new' do
  let(:files) { %w(job_desc.txt resume1.doc resume2.docx resume3.pdf) }

  it 'returns a document given different file types' do
    files.each do |file|
      doc = DocRank::Document.new "#{RSPEC_ROOT}/sample_texts/#{file}"
      expect(doc).to be_a(DocRank::Document)
    end
  end

  it 'returns a document with name, text, and weighted_keywords' do
    files.each do |file|
      doc = DocRank::Document.new "#{RSPEC_ROOT}/sample_texts/#{file}"
      expect(doc.name).to eq(file)
      expect(doc.text).to be_a(String)
      expect(doc.weighted_keywords).to be_a(Hash)
      doc.weighted_keywords.each do |kw, weight|
        expect(kw).to be_a(String)
        expect(weight).to be_a(Float)
      end
    end
  end

  it 'raises an error when file not found' do
    expect{DocRank::Document.new("bad/path")}.to raise_error(Errno::ENOENT)
  end
end
