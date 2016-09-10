require 'spec_helper'
require 'order_engine'

describe OrderEngine do

  describe '.new' do

    it 'responds to response' do
      order_engine = OrderEngine.new('order', 'catalogue')

      expect(order_engine).to respond_to(:response)
    end

    it 'responds to catalogue' do
      order_engine = OrderEngine.new('order', 'catalogue')

      expect(order_engine).to respond_to(:catalogue)
    end
  end

  describe '#run' do
    let(:order_engine) { OrderEngine.new('order', 'catalogue') }
    let(:invoicer) { instance_double('Invoicer', details: 'total $$') }

    before do
      allow(OrderPacker).to receive(:run)
      allow(Invoicer).to receive(:create) { invoicer }
    end

    it 'packs order' do
      expect(OrderPacker).to receive(:run)

      order_engine.run
    end

    it 'creates invoice' do
      expect(Invoicer).to receive(:create)

      order_engine.run
    end

    it 'assigns invoice to response' do
      order_engine.run

      expect(order_engine.response).to eq('total $$')
    end
  end
end
