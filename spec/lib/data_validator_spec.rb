require 'spec_helper'
require 'data_validator'
require 'catalogue'

describe DataValidator do
  let(:catalogue) { Catalogue.create }

  context 'when data is ok' do
    it 'is valid' do
      allow(CSV).to receive(:read) { [["10 R12"], ["15 L09"], ["13 T58"]] }
      resp = DataValidator.validate(catalogue)
      expect(resp.valid?).to eq(true)
    end
  end
  context 'when data in wrong format' do
    let(:resp) { DataValidator.validate(catalogue) }

    before { allow(CSV).to receive(:read) { [["ten R12"], ["15 L09"]] } }

    it 'is invalid' do
      expect(resp.valid?).to eq(false)
    end
    it 'assigns incorrect file type error message' do
      msg = "Error: Invalid data. Please check the content of order.csv"
      expect(resp.error_message).to eq(msg)
    end
  end
end
