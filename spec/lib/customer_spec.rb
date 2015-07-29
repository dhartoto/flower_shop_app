require 'spec_helper'
require 'customer'

describe Customer do

  describe Customer::File do
    describe '.get' do

      context 'when file is valid' do
        it 'reads file from order.csv' do
          file = Customer::File.get
          expected_array = [["10 R12"], ["15 L09"], ["13 T58"]]
          expect(file).to eq(expected_array)
        end
      end
      context 'when file is not present'
      context 'when file is empty'
      context 'when file in wrong format'
      context 'when data  in wrong format'
    end
  end
end
