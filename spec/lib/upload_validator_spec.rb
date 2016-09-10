require 'spec_helper'
require 'upload_validator'
require 'exceptions'

describe UploadValidator do

  context 'when order is ok' do
    it 'returns true' do
      allow(File).to receive(:exists?) { true }

      expect(UploadValidator.validate).to eq(true)
    end
  end

  context 'when file does exist' do

    before { allow(File).to receive(:exists?) { false } }

    it "raises FileError exception with error message" do
      error_message = "Error: File not found. Please save order.csv to public/uploads folder."

      expect { UploadValidator.validate }.to raise_exception(
        Application::FileError,
        error_message
      )
    end
  end

  context 'when file is empty' do

    before { allow(File).to receive_messages(exists?: true, zero?: true) }

    it "raises FileError exception with error message" do
      error_message = "Error: File empty. Please check content of order.csv."

      expect { UploadValidator.validate }.to raise_exception(
        Application::FileError,
        error_message
      )
    end
  end
end
