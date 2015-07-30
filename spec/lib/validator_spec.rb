require 'spec_helper'
require 'validator'
require 'catalogue'

describe Validator do
  let(:catalogue) { Catalogue.create }

  context 'when no error' do
    it 'is valid' do
      validator = instance_double('Validator', valid?: true)
      allow(UploadValidator).to receive(:validate) { validator }
      allow(DataValidator).to receive(:validate) { validator }
      allow(OrderValidator).to receive(:validate) { validator }
      resp = Validator.validate(catalogue)
      expect(resp.valid?).to eq(true)
    end
  end

  let(:resp) { instance_double('Validator') }

  context 'when upload error' do
    it 'return upload error message' do
      allow(resp).to receive(:valid?).and_return(false, true, true)
      allow(resp).to receive(:error_message) { 'file error' }
      allow(UploadValidator).to receive(:validate) { resp }
      allow(DataValidator).to receive(:validate) { resp }
      allow(OrderValidator).to receive(:validate) { resp }
      resp = Validator.validate(catalogue)
      expect(resp.error_message).to eq('file error')
    end
  end

  context 'when data error' do
    it 'return data error message' do
      allow(resp).to receive(:valid?).and_return(true, false, true)
      allow(resp).to receive(:error_message) { 'data error' }
      allow(UploadValidator).to receive(:validate) { resp }
      allow(DataValidator).to receive(:validate) { resp }
      allow(OrderValidator).to receive(:validate) { resp }
      resp = Validator.validate(catalogue)
      expect(resp.error_message).to eq('data error')
    end
  end

  context 'when order error' do
    it 'return order error message' do
      allow(resp).to receive(:valid?).and_return(true, true, false)
      allow(resp).to receive(:error_message) { 'order error' }
      allow(UploadValidator).to receive(:validate) { resp }
      allow(DataValidator).to receive(:validate) { resp }
      allow(OrderValidator).to receive(:validate) { resp }
      resp = Validator.validate(catalogue)
      expect(resp.error_message).to eq('order error')
    end
  end
end
