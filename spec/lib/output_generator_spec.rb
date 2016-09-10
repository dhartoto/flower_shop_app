require 'spec_helper'
require 'output_generator'
require 'ostruct'
require 'pack'
require 'catalogue'

describe OutputGenerator do

  describe '.run' do
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
        output = OutputGenerator.run(package)

        expect(output.package.packs).to eq(packs)
      end

      it 'should return breakdown of bundles' do
        output = OutputGenerator.run(package)
        details = "15 R12 $19.98\n\t1 x 5 $6.99\n\t1 x 10 $12.99\n"

        expect(output.details).to eq(details)
      end
    end

    context 'when multiple product order' do
      let(:catalogue) { Catalogue.create }

      let(:packs) do
        [Pack.new(
          code: 'R12',
          total_quantity: 10,
          bundles: { 10 => 1 },
          catalogue: catalogue
          ),
        Pack.new(
          code: 'L09',
          total_quantity: 15,
          bundles: { 9 => 1, 6 => 1 },
          catalogue: catalogue
          ),
        Pack.new(
          code: 'T58',
          total_quantity: 13,
          bundles: { 5 => 2, 3 => 1 },
          catalogue: catalogue
          )]
      end

      let(:package) { OpenStruct.new(packs: packs) }

      it 'should return breakdown of bundles' do
        output = OutputGenerator.run(package)
        details = "10 R12 $12.99\n\t1 x 10 $12.99\n"\
          "15 L09 $41.9\n\t1 x 6 $16.95\n\t1 x 9 $24.95\n"\
          "13 T58 $25.85\n\t1 x 3 $5.95\n\t2 x 5 $19.9\n"

        expect(output.details).to eq(details)
      end
    end
  end
end
