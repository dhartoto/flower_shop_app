require 'spec_helper'
require 'flower_shop'

describe FlowerShop do
  describe '.new' do
    it { should be_an_instance_of(FlowerShop) }

    it 'should have instructions to display'
    it 'should have products'
  end
end
