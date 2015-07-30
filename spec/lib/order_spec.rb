require 'spec_helper'
require 'order'

describe Order do

  describe '.new' do
    it 'assigns empty array to items' do
      order = Order.new
      expect(order.items).to eq([])
    end
  end

  describe '#create' do
    let(:order) { Order.new }
    before { allow(Item).to receive(:create) }

    it 'retreives customer order file' do
      content = [["10 R12"], ["15 L09"], ["13 T58"]]
      file = instance_double('OrderFile', content: content)
      expect(OrderFile).to receive(:get) { file }
      order.create
    end
  end
end
