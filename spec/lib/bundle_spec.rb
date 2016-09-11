require 'spec_helper'
require 'item'
require 'bundle'
require 'catalogue'

describe Bundle do
  let(:catalogue) { Catalogue.create }
  let(:item) { Item.new(code: 'T58', quantity: 13) }

  describe '.create' do
    it 'creates a bundle with product code' do
      bundle = Bundle.create(item, catalogue)

      expect(bundle.code).to eq(item.code)
    end

    it 'creates a bundle with quantity' do
      bundle = Bundle.create(item, catalogue)

      expect(bundle.order_quantity).to eq(item.quantity)
    end

    it 'creates a bundle with catalogue' do
      bundle = Bundle.create(item, catalogue)

      expect(bundle.catalogue).to eq(catalogue)
    end

    context 'when one order is for Tulip (T58)' do
      it 'returns 1 x 3 for order quantity 3' do
        item = Item.new(code: 'T58', quantity: 3)
        bundle = Bundle.create(item, catalogue)

        expect(bundle.breakdown).to eq({3 => 1})
      end

      it 'returns 1 x 9 for order quantity 9' do
        item = Item.new(code: 'T58', quantity: 9)
        bundle = Bundle.create(item, catalogue)

        expect(bundle.breakdown).to eq({ 9 => 1 })
      end

      it 'returns 1 x 9 and 1 x 5 for order quantity 14' do
        item = Item.new(code: 'T58', quantity: 14)
        bundle = Bundle.create(item, catalogue)

        expect(bundle.breakdown).to eq({ 9 => 1, 5 => 1 })
      end

      it 'returns 1 x 9 and 2 x 3 for order quantity 15' do
        item = Item.new(code: 'T58', quantity: 15)
        bundle = Bundle.create(item, catalogue)

        expect(bundle.breakdown).to eq({3=>2, 9=>1})
      end

      it 'returns 1 x 5 and 2 x 3 for order quantity 11' do
        item = Item.new(code: 'T58', quantity: 11)
        bundle = Bundle.create(item, catalogue)

        expect(bundle.breakdown).to eq({ 5 => 1, 3 => 2 })
      end

      it 'returns 2 x 9 and 1 x 3 for order quantity 21' do
        item = Item.new(code: 'T58', quantity: 21)
        bundle = Bundle.create(item, catalogue)

        expect(bundle.breakdown).to eq({ 9 => 2, 3 => 1 })
      end

      it 'returns 1 x 9, 1 x 5 and 1 x 3 for order quantity 17' do
        item = Item.new(code: 'T58', quantity: 17)
        bundle = Bundle.create(item, catalogue)

        expect(bundle.breakdown).to eq({ 9 => 1, 5 => 1, 3 => 1 })
      end
    end
  end
end
