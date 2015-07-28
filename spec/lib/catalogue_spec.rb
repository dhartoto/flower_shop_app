require 'spec_helper'
require 'catalogue'

describe Catalogue do
  it { should be_an_instance_of(Catalogue) }
  describe '.create' do
    let(:yaml_mock) do
      { "R12" => {
        "name" => "Roses",
        "bundles" => {
          5 => 6.99,
          10 => 12.99 }
        },
        "L09" => {
          "name" => "Lilies",
          "bundles" => {
            3 => 16.99,
            6 => 16.95,
            9 => 24.95 }
          }
      }
    end

    before do
      allow(YAML).to receive(:load_file) { yaml_mock }
    end

    it 'responds to products' do
      catalogue = Catalogue.create
      expect(catalogue).to respond_to :products
    end
    it 'assigns a hash of products' do
      catalogue = Catalogue.create
      expect(catalogue.products.first).to be_an_instance_of(Hash)
    end
    it 'assigns a hash of products with name' do
      catalogue = Catalogue.create
      product = catalogue.products.first
      expect(product['name']).to be_an_instance_of('Roses')
    end
    it 'assigns a hash of products with name' do
      catalogue = Catalogue.create
      product = catalogue.products.first
      expected_hash = { 5 => 6.99, 10 => 12.99 }
      expect(product['bundles']).to be_an_instance_of(expected_hash)
    end
  end
end
