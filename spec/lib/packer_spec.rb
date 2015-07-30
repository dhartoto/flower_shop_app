require 'spec_helper'
require 'ostruct'
require 'packer'

describe Packer do
  describe '.pack' do
    let(:items) { ['item_1'] }
    let(:order) { OpenStruct.new(items: items) }

    it 'assigns order to packer' do
      package = Packer.pack(order)
      expect(package.order).to eq(order)
    end
    it 'responds to packs' do
      package = Packer.pack(order)
      expect(package).to respond_to(:packs)
    end
    it 'creates one pack if there is one order' do
      expect(Pack).to receive(:create)
      Packer.pack(order)
    end

    context 'when multiple items in order' do
      it 'creates 3 packs if there are 3 orders' do
        items = ['item_1', 'item_2', 'item_3']
        order = OpenStruct.new(items: items)
        expect(Pack).to receive(:create).exactly(3).times
        Packer.pack(order)
      end
    end
  end
end
