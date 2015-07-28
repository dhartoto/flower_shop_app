require 'spec_helper'
require 'flower_shop'

describe FlowerShop do
  describe '.new' do
    before { allow(Products).to receive(:all) }

    it { should be_an_instance_of(FlowerShop) }

    it 'should have instructions to display' do
      msg = "Please save Order CSV file into the 'uploads' folder then enter"\
        " '1' to calculate costs and bundle breakdown, or '2' to exit."
      expect(subject.display).to eq(msg)
    end
    it 'should have products' do
      expect(Products).to receive(:all)
      FlowerShop.new
    end
  end

  describe '#run' do
    let(:app) { FlowerShop.new }
    let(:order_filler) { instance_double('OrderFiller', message: 'some message') }

    before do
      allow(Products).to receive(:all)
      allow(OrderFiller).to receive(:fill) { order_filler }
    end

    context 'when user enters 1 to calculate costs and bundle' do
      before { allow(app).to receive(:gets) { '1' } }

      it 'fills order' do
        expect(OrderFiller).to receive(:fill)
        app.run
      end
      it 'displays message to user' do
        app.run
        expect(app.display).to eq('some message')
      end
    end

    context 'when user enters 2 to exit program' do
      before { allow(app).to receive(:gets) { '2' } }

      it 'does not fill order' do
        expect(OrderFiller).not_to receive(:fill)
        app.run
      end
      it 'displays exit message to user' do
        app.run
        expect(app.display).to eq("Exiting the Flower Shop")
      end
    end
  end
end
