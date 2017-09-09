require 'spec_helper'

RSpec.describe 'DocRank::Document#new' do
  let(:files) { %w(job_desc.txt resume1.doc resume2.docx resume3.pdf) }

  it 'returns a document object with name, text, and keywords' do
    files.each do |file|
      doc = DocRank::Document.new "#{RSPEC_ROOT}/sample_texts/#{file}"
      expect(doc).to be_a(DocRank::Document)
      expect(doc.text).to be_a(String)
      expect(doc.name).to eq(file)
      expect(doc.keywords).to be_a(Highscore::Keywords)
    end
  end

  it 'raises an error when file not found' do
    expect{DocRank::Document.new("bad/path")}.to raise_error(Errno::ENOENT)
  end
end
