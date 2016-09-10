require 'spec_helper'
require 'order'

describe Order do
  describe '.create' do
    before { allow(Item).to receive(:create) }

    it 'retreives customer order file' do
      content = [["10 R12"], ["15 L09"], ["13 T58"]]
      file = instance_double('OrderFile', content: content)
      expect(OrderFile).to receive(:get) { file }

      Order.create
    end
  end
end
