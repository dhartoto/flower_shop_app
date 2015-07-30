require 'spec_helper'
require 'packer'
require 'order'

describe Packer do
  let(:order) { Order.new }

  describe '.pack' do
    it 'assigns order to packer' do
      package = Packer.pack(order)
      expect(package.order).to eq(order)
    end
    it 'creates one pack if there is one order'
    it 'creates many packs if there are mnay orders'
  end
end
