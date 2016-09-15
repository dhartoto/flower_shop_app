require 'spec_helper'
require 'item'

describe Item do
  describe '.create' do
    let(:line) { ["10 R12"] }
    let(:item) { Item.create(line) }

    it 'creates an instance of Item' do
      expect(item).to be_an_instance_of(Item)
    end
    it 'assigns code from argument' do
      expect(item.code).to eq('R12')
    end
    it 'assigns quantity from argument' do
      expect(item.quantity).to eq(10)
    end
  end
end
