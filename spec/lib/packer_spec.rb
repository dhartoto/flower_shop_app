require 'spec_helper'
require 'packer'

describe Packer do
  let(:items) { ['item_1', 'item_2'] }
  let(:order) { OpenStruct.new(items: items) }

  describe '.pack' do
    it 'assigns order to packer' do
      package = Packer.pack(order)
      expect(package.order).to eq(order)
    end
    it 'creates one pack if there is one order' do
      expect(Pack).to receive(:create)
      Packer.pack(order)
    end
    it 'creates 3 packs if there are 3 orders' do
      expect(Pack).to receive(:create).exactly(3).times
      Packer.pack(order)
    end
  end
end
