require 'spec_helper'
require 'invoicer'
require 'ostruct'
require 'pack'
require 'catalogue'
require 'pry'

describe Invoicer do

  describe '.create' do
    context 'when single product order' do
      let(:catalogue) { Catalogue.create }

      let(:packs) do
        [Pack.new(
          code: 'R12',
          total_quantity: 15,
          bundles: { 5 => 1, 10 => 1 },
          catalogue: catalogue
          )]
      end

      let(:package) { OpenStruct.new(packs: packs) }

      it 'has an order package' do
        invoice = Invoicer.create(package)
        expect(invoice.package.packs).to eq(packs)
      end
      it 'should return total order value' do
        invoice = Invoicer.create(package)
        expect(invoice.total_value).to eq(19.98)
      end
      it 'should return breakdown of bundles' do
        invoice = Invoicer.create(package)
        details = "15 R12 $19.98\n\t1 x 5 $6.99\n\t1 x 10 $12.99\n"
        expect(invoice.details).to eq(details)
      end
    end

  #   context 'when multiple product order'
  end
end
