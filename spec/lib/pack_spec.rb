require 'spec_helper'
require 'item'
require 'pack'
require 'catalogue'

describe Pack do
  let(:catalogue) { Catalogue.create }
  let(:item) { Item.new(code: 'T58', quantity: 13) }

  describe '.create' do
    it 'creates a pack with product code' do
      pack = Pack.create(item, catalogue)
      expect(pack.code).to eq(item.code)
    end
    it 'creates a pack with quantity' do
      pack = Pack.create(item, catalogue)
      expect(pack.total_quantity).to eq(item.quantity)
    end
    it 'creates a pack with catalogue' do
      pack = Pack.create(item, catalogue)
      expect(pack.catalogue).to eq(catalogue)
    end
  end

  describe '.create_bundles' do
    context 'when one order is for Tulip (T58)' do
      it 'returns 1 x 3 for order quantity 3' do
        item = Item.new(code: 'T58', quantity: 3)
        pack = Pack.create(item, catalogue)
        pack.create_bundles
        expect(pack.bundles).to eq({3 => 1})
      end
      it 'returns 1 x 9 for order quantity 9' do
        item = Item.new(code: 'T58', quantity: 9)
        pack = Pack.create(item, catalogue)
        pack.create_bundles
        expect(pack.bundles).to eq({ 9 => 1 })
      end
      it 'returns 1 x 9 and 1 x 5 for order quantity 14' do
        item = Item.new(code: 'T58', quantity: 14)
        pack = Pack.create(item, catalogue)
        pack.create_bundles
        expect(pack.bundles).to eq({ 9 => 1, 5 => 1 })
      end
      it 'returns 1 x 9 and 2 x 3 for order quantity 15' do
        item = Item.new(code: 'T58', quantity: 15)
        pack = Pack.create(item, catalogue)
        pack.create_bundles
        expect(pack.bundles).to eq({3=>2, 9=>1})
      end
      it 'returns 1 x 5 and 2 x 3 for order quantity 11' do
        item = Item.new(code: 'T58', quantity: 11)
        pack = Pack.create(item, catalogue)
        pack.create_bundles
        expect(pack.bundles).to eq({ 5 => 1, 3 => 2 })
      end
      it 'returns 2 x 9 and 1 x 3 for order quantity 21' do
        item = Item.new(code: 'T58', quantity: 21)
        pack = Pack.create(item, catalogue)
        pack.create_bundles
        expect(pack.bundles).to eq({ 9 => 2, 3 => 1 })
      end
      it 'returns 1 x 9, 1 x 5 and 1 x 3 for order quantity 17' do
        item = Item.new(code: 'T58', quantity: 17)
        pack = Pack.create(item, catalogue)
        pack.create_bundles
        expect(pack.bundles).to eq({ 9 => 1, 5 => 1, 3 => 1 })
      end
    end
  end
end
