require 'spec_helper'
require 'order_engine'

describe OrderEngine do
  describe '.new' do
    it 'responds to response' do
      order_engine = OrderEngine.new('catalogue')
      expect(order_engine).to respond_to(:response)
    end
    it 'responds to catalogue' do
      order_engine = OrderEngine.new('catalogue')
      expect(order_engine).to respond_to(:catalogue)
    end
    it 'gets an Order' do
      expect(Order).to receive(:new)
      order_engine = OrderEngine.new('catalogue')
    end
  end
end
