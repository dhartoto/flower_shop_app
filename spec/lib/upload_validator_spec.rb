require 'spec_helper'
require 'upload_validator'
require 'catalogue'

describe UploadValidator do
  let(:catalogue) { Catalogue.create }

  context 'when order is ok' do
    it 'is valid' do
      allow(File).to receive(:exists?) { true }
      resp = UploadValidator.validate(catalogue)
      expect(resp.valid?).to eq(true)
    end
  end

  context 'when file does exist' do
    let(:resp) { UploadValidator.validate(catalogue) }

    before { allow(File).to receive(:exists?) { false } }

    it 'is invalid' do
      expect(resp.valid?).to eq(false)
    end
    it 'assigns file not found error' do
      msg = "Error: File not found. Please save order.csv to public/uploads"\
        "folder."
      expect(resp.error_message).to eq(msg)
    end
  end

  context 'when file is empty' do
    let(:resp) { UploadValidator.validate(catalogue) }

    before do
      allow(File).to receive_messages(exists?: true, zero?: true)
    end

    it 'is invalid' do
      expect(resp.valid?).to eq(false)
    end
    it 'assigns file empty error' do
      msg = "Error: File empty. Please check content of order.csv."
      expect(resp.error_message).to eq(msg)
    end
  end

end
