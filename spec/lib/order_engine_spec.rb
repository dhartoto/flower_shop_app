require 'spec_helper'
require 'order_engine'

describe OrderEngine do

  describe '.new' do
    before { allow(Order).to receive_message_chain(:new, :create) }

    it 'responds to response' do
      order_engine = OrderEngine.new('catalogue')

      expect(order_engine).to respond_to(:response)
    end
    it 'responds to catalogue' do
      order_engine = OrderEngine.new('catalogue')

      expect(order_engine).to respond_to(:catalogue)
    end
  end

  describe '#run' do
    let(:order_engine) { OrderEngine.new('catalogue') }
    let(:invoicer) { instance_double('Invoicer', details: 'total $$') }

    before do
      allow(Order).to receive_message_chain(:new, :create)
      allow(Packer).to receive(:pack)
      allow(Invoicer).to receive(:create) { invoicer }
    end

    it 'gets an Order' do
      expect(Order).to receive(:new)
      order_engine.run
    end
    it 'packs order' do
      expect(Packer).to receive(:pack)
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
