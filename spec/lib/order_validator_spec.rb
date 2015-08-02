require 'spec_helper'
require 'order_validator'
require 'catalogue'

describe OrderValidator do
  let(:catalogue) { Catalogue.create }

  describe '.validate' do
    context 'when order is ok' do
      it 'is valid' do
        allow(CSV).to receive(:read) { [["10 R12"], ["15 L09"], ["13 T58"]] }
        resp = OrderValidator.validate(catalogue)
        expect(resp.valid?).to eq(true)
      end
    end

    context 'when order cannot be filled' do
      let(:resp) { OrderValidator.validate(catalogue) }

      before { allow(CSV).to receive(:read) { [["13 R12"], ["15 L09"]] } }

      it 'is invalid' do
        expect(resp.valid?).to eq(false)
      end
      it 'assigns invalid order error message' do
        msg = "Error: Invalid order quantity. Please verify with client."
        expect(resp.error_message).to eq(msg)
      end
    end
  end

  # TDD for building unfillable? algorithm
  # commented out because method is private
  describe '.unfillalbe?' do
    context 'when one order is for Tulip (T58)' do
      it 'returns false if order is 3' do
        allow(CSV).to receive(:read) { [["3 T58"]] }
        resp = OrderValidator.unfillable?(catalogue)
        expect(resp).to eq(false)
      end
      it 'returns false if order is 9' do
        allow(CSV).to receive(:read) { [["9 T58"]] }
        resp = OrderValidator.unfillable?(catalogue)
        expect(resp).to eq(false)
      end
      it 'returns true if order is 4' do
        allow(CSV).to receive(:read) { [["4 T58"]] }
        resp = OrderValidator.unfillable?(catalogue)
        expect(resp).to eq(true)
      end
      it 'returns false if order is 15' do
        allow(CSV).to receive(:read) { [["15 T58"]] }
        resp = OrderValidator.unfillable?(catalogue)
        expect(resp).to eq(false)
      end
      it 'returns false if order is 13' do
        allow(CSV).to receive(:read) { [["13 T58"]] }
        resp = OrderValidator.unfillable?(catalogue)
        expect(resp).to eq(false)
      end
      it 'returns false if order is 11' do
        allow(CSV).to receive(:read) { [["11 T58"]] }
        resp = OrderValidator.unfillable?(catalogue)
        expect(resp).to eq(false)
      end
    end
    context 'when multiple orders' do
      it 'returns false if all orders are fillable' do
        allow(CSV).to receive(:read) { [["10 R12"], ["13 T58"]] }
        resp = OrderValidator.unfillable?(catalogue)
        expect(resp).to eq(false)
      end
      it 'returns true if one order is unfillable' do
        allow(CSV).to receive(:read) { [["10 R12"], ["5, L09"], ["16 T58"]] }
        resp = OrderValidator.unfillable?(catalogue)
        expect(resp).to eq(true)
      end
    end
  end
end
