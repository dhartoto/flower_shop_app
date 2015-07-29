require 'spec_helper'
require 'customer'

describe Customer do

  describe Customer::File do
    describe '.get' do
      let(:file) { Customer::File.get }

      context 'when file is valid' do
        it 'assigns file to content attribute' do
          expected_array = [["10 R12"], ["15 L09"], ["13 T58"]]
          expect(file.content).to eq(expected_array)
        end
      end
      context 'when file is not present' do
        it 'assigns file not present error message' do
          msg = "Error: File not found. Please save order.csv to public/uploads"\
            "folder."
          expect(file.error_message).to eq(msg)
        end
      end
      context 'when file is empty' do
        it 'assigns file empty error message' do
          msg = "Error: File empty. Please check content of order.csv."
          expect(file.error_message).to eq(msg)
        end
      end
      context 'when file in wrong format' do
        it 'assigns incorrect file type error message' do
          msg = "Error: Incorrect file type. Please save 'order' as a CSV file."
          expect(file.error_message).to eq(msg)
        end
      end
      context 'when data in wrong format' do
        it 'assigns incorrect file type error message' do
          msg = "Error: Invalid data. Please check the content of order.csv"
          expect(file.error_message).to eq(msg)
        end
      end
    end
  end
end
