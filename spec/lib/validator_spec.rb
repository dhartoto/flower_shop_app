require 'spec_helper'
require 'validator'
require 'catalogue'

describe Validator do
  let(:catalogue) { Catalogue.create }

  context 'when no error' do
    before do
      allow(UploadValidator).to receive(:validate)
      allow(DataValidator).to receive(:validate)
    end

    it 'returns true' do
      expect(Validator.validate(catalogue)).to eq(true)
    end
  end

  context 'when upload error' do
    it 'raises file not found exception' do
      allow(UploadValidator).to receive(:validate)
        .and_raise(Application::FileError)
      allow(DataValidator).to receive(:validate)

      expect { Validator.validate(catalogue) }
        .to raise_exception(Application::FileError)
    end
  end

  context 'when data error' do
    it 'return data error message' do
      allow(UploadValidator).to receive(:validate)
      allow(DataValidator).to receive(:validate)
        .and_raise(Application::DataError)

      expect { Validator.validate(catalogue) }
        .to raise_exception(Application::DataError)
    end
  end
end
