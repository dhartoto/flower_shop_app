require 'spec_helper'
require 'flower_shop'
require 'products'

describe FlowerShop do
  describe '.new' do
    before { allow(Products).to receive(:all) }

    it { should be_an_instance_of(FlowerShop) }
    
    it 'should have instructions to display' do
      msg = "Please save Order CSV file into the 'uploads' folder then enter 1"\
        " to create invoice, or 2. to exit."
      expect(subject.display).to eq(msg)
    end
    it 'should have products' do
      expect(Products).to receive(:all)
      FlowerShop.new
    end
  end
end
