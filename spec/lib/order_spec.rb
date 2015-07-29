require 'spec_helper'
require 'order'
require 'catalogue'

describe Order do
  describe '.new' do
    it 'assigns an instance of catalogue' do
      order = Order.new(Catalogue.new)
      expect(order.catalogue).to be_an_instance_of(Catalogue)
    end
  end
end
