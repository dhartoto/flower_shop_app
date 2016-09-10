require 'spec_helper'
require 'ostruct'
require 'order_packer'
require 'catalogue'

describe OrderPacker do
  let(:catalogue) { Catalogue.create }

  describe '.run' do
    let(:items) { ['item_1'] }
    let(:order) { OpenStruct.new(items: items) }

    before { allow(Pack).to receive(:create) }

    it 'assigns order to packer' do
      package = OrderPacker.run(order, catalogue)

      expect(package.order).to eq(order)
    end

    it 'responds to packs' do
      package = OrderPacker.run(order, catalogue)

      expect(package).to respond_to(:packs)
    end

    it 'creates one pack if there is one order' do
      expect(Pack).to receive(:create)

      OrderPacker.run(order, catalogue)
    end

    context 'when multiple items in order' do
      let(:items) { ['item_1', 'item_2', 'item_3'] }

      it 'creates 3 packs if there are 3 orders' do
        expect(Pack).to receive(:create).exactly(3).times

        OrderPacker.run(order, catalogue)
      end
    end
  end
end
