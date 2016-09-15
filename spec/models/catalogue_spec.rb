require 'spec_helper'
require 'catalogue'

describe Catalogue do

  let(:yaml_mock) do
    { "R12" => {
      "name" => "Roses",
      "bundles" => {
        5 => 6.99,
        10 => 12.99 }
      }
    }
  end

  before do
    allow(YAML).to receive(:load_file) { yaml_mock }
  end

  let(:catalogue) { Catalogue.create }

  describe '.create' do
    let(:product) { catalogue.products['R12'] }

    it 'responds to products' do
      expect(catalogue).to respond_to :products
    end
    it 'assigns a hash of products' do
      expect(product).to be_an_instance_of(Hash)
    end
    it 'assigns a hash of products with name' do
      expect(product['name']).to eq('Roses')
    end
    it 'assigns a hash of products with name' do
      expected_hash = { 5 => 6.99, 10 => 12.99 }
      expect(product['bundles']).to eq(expected_hash)
    end
  end

  describe '#find' do
    let(:product) { catalogue.find('R12') }

    it 'returns a hash' do
      expected_hash = {"name"=>"Roses", "bundles"=>{5=>6.99, 10=>12.99}}
      expect(catalogue.find('R12')).to eq(expected_hash)
    end
    it 'returns hash with name' do
      expect(product['name']).to eq('Roses')
    end
    it 'returns hash with bundles' do
      expected_hash = { 5 => 6.99, 10 => 12.99 }
      expect(product['bundles']).to eq(expected_hash)
    end
  end
end
