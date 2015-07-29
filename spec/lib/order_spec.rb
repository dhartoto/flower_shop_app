require 'spec_helper'
require 'order'
require 'catalogue'

describe Order do
  let(:catalogue) { Catalogue.new }

  describe '.new' do
    it 'assigns an instance of catalogue' do
      order = Order.new(catalogue)
      expect(order.catalogue).to be_an_instance_of(Catalogue)
    end
    it 'assigns empty array to items' do
      order = Order.new(catalogue)
      expect(order.items).to eq([])
    end
  end

  describe '#create' do
    let(:order) { Order.new(catalogue) }
    before { allow(Item).to receive(:create) }

    it 'retreives customer order file' do
      content = [["10 R12"], ["15 L09"], ["13 T58"]]
      file = instance_double('Customer::File', valid?: true, content: content)
      expect(Customer::File).to receive(:retreive) { file }
      order.create
    end

    context 'when file is valid' do
      let(:content) { [["10 R12"], ["15 L09"], ["13 T58"]] }
      let(:file) do
        instance_double('Customer::File', valid?: true, content: content)
      end

      before { allow(Customer::File).to receive(:retreive) { file } }

      it 'creates items' do
        expect(Item).to receive(:create).exactly(3).times
        order.create
      end
      it 'appends item to items attribute' do
        order.create
        expect(order.items.count).to eq(3)
      end
    end

    context 'when file is invalid' do
      let(:file) do
        instance_double('Customer::File', valid?: false, error_message: 'error')
      end

      before { allow(Customer::File).to receive(:retreive) { file } }

      it 'does not create items' do
        expect(Item).not_to receive(:create)
        order.create
      end
      it 'assigns error message' do
        order.create
        expect(order.error_message).to eq('error')
      end
    end
  end
end
