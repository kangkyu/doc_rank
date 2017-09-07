require 'spec_helper'
 RSpec.describe 'DocRank::Document#text' do
   pwd = File.dirname(__FILE__)
   let(:pdf_file){ "#{pwd}/sample_data/sample.pdf" }
   let(:pdf_document){ DocRank::Document.new pdf_file }

   let(:docx_file){ "#{pwd}/sample_data/sample.docx" }
   let(:docx_document){ DocRank::Document.new docx_file }

   let(:txt_file){ "#{pwd}/sample_data/sample.txt" }
   let(:txt_document){ DocRank::Document.new txt_file }

   it 'returns the text of a given .pdf file' do
      expect(pdf_document.text).to be_a(String)
   end
   it 'returns the text of a given .docx file' do
      expect(docx_document.text).to be_a(String)
   end
   it 'returns the text of a given .txt file' do
      expect(txt_document.text).to be_a(String)
   end
 end
