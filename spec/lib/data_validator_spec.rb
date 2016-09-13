require 'spec_helper'
require 'data_validator'
require 'exceptions'

describe DataValidator do

  context 'when data is ok' do

    it 'returns true' do
      allow(CSV).to receive(:read) { [["10 R12"], ["15 L09"], ["13 T58"]] }

      expect(DataValidator.validate).to eq(true)
    end
  end

  context 'when data errors exists' do
    let(:error_message) do
      "Error: Invalid data. Please check the content of order.csv"
    end

    context 'when quantity is not an integer' do
      before { allow(CSV).to receive(:read) { [["ten R12"], ["15 L09"]] } }

      it 'raises DataError with error message' do
        expect { DataValidator.validate }
          .to raise_exception(Application::DataError, error_message)
      end
    end

    context 'when product code is incorrect' do
      before { allow(CSV).to receive(:read) { [["10 Z12"]] } }

      it 'raises DataError with error message' do
        expect { DataValidator.validate }
          .to raise_exception(Application::DataError, error_message)
      end
    end
  end
end
