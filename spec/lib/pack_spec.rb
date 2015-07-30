require 'spec_helper'
require 'item'
require 'pack'

describe Pack do
  let(:item) { Item.new(code: 'T58', quantity: '13') }

  describe '.create' do
    it 'creates a pack with product code' do
      pack = Pack.create(item)
      expect(pack.code).to eq(item.code)
    end
    it 'creates a pack with quantity' do
      pack = Pack.create(item)
      expect(pack.quantity).to eq(item.quantity)
    end
  end

  # TDD build calculate_quantity algorithm
  #

  describe '.calculate_quantity' do
    context 'when one order is for Tulip (T58)' do
      it 'returns false if order is 3'
      it 'returns false if order is 9'
      it 'returns true if order is 4'
      it 'returns false if order is 15'
      it 'returns false if order is 13'
    end
  end
end
