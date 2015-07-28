require 'spec_helper'
require 'catalogue'

describe Catalogue do
  it { should be_an_instance_of(Catalogue) }
  describe '.create' do
    let(:yaml_mock) do
      { "R12" => {
        "name" => "Roses",
        "bundle" => {
          5 => 6.99,
          10 => 12.99
          }
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
    it 'assigns list of Structs to products' do
      catalogue = Catalogue.create
      expect(catalogue.products.first).to be_an_instance_of(Struct)
    end
    it 'creates product that responds to name' do
      catalogue = Catalogue.create
      expect(catalogue.products.first).to respond_to(:name)
    end
    it 'creates product that responds to bunch' do
      catalogue = Catalogue.create
      expect(catalogue.products.first).to respond_to(:bunch)
    end
  end
end
