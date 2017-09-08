require 'spec_helper'
 RSpec.describe 'DocRank::Document#get_doc_content' do
   pwd = File.dirname(__FILE__)
   let(:pdf_file){ "#{pwd}/sample_data/sample.pdf" }
   let(:pdf_document){ DocRank::Document.new pdf_file }

   let(:docx_file){ "#{pwd}/sample_data/sample.docx" }
   let(:docx_document){ DocRank::Document.new docx_file }

   let(:txt_file){ "#{pwd}/sample_data/sample.txt" }
   let(:txt_document){ DocRank::Document.new txt_file }

   let(:err_file){ "#{pwd}/sample_data/sample.csv" }
   let(:err_document){ DocRank::Document.new err_file }

   it 'returns the text of a given .pdf file' do
      expect(pdf_document.send(:get_doc_content, pdf_file)).to be_a(String)
   end
   it 'returns the text of a given .docx file' do
      expect(docx_document.send(:get_doc_content, docx_file)).to be_a(String)
   end
   it 'returns the text of a given .txt file' do
      expect(txt_document.send(:get_doc_content, txt_file)).to be_a(String)
   end
   it 'throws an ArgumentError when non supported file provided' do
      expect { err_document.send(:get_doc_content, err_file) }.to raise_error("File not supported.")
   end
 end
