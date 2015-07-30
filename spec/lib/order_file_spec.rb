require 'spec_helper'
require 'order_file'
require 'catalogue'

describe OrderFile do
  let(:catalogue) { Catalogue.create }

  describe '.get' do
    let(:file) { OrderFile.get(catalogue) }

    context 'when file is valid' do
      it 'assigns file to content attribute' do
        expected_array = [["10 R12"], ["15 L09"], ["13 T58"]]
        expect(file.content).to eq(expected_array)
      end
    end

    context 'when file is not present' do
      it 'assigns file not present error message' do
        allow(File).to receive(:exists?) { false }
        msg = "Error: File not found. Please save order.csv to public/uploads"\
          "folder."
        expect(file.error_message).to eq(msg)
      end
    end

    context 'when file is empty' do
      it 'assigns file empty error message' do
        allow(File).to receive(:zero?) { true }
        msg = "Error: File empty. Please check content of order.csv."
        expect(file.error_message).to eq(msg)
      end
    end

    context 'when data in wrong format' do
      it 'assigns incorrect file type error message' do
        allow(CSV).to receive(:read) { [["10 R13"], ["12 T59"]] }
        msg = "Error: Invalid data. Please check the content of order.csv"
        expect(file.error_message).to eq(msg)
      end
    end
  end
end