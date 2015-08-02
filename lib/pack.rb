require 'fillable'

class Pack
  include Fillable

  def self.create(item, catalogue)
    new(
      code: item.code,
      total_quantity: item.quantity,
      catalogue: catalogue
      )
  end

  attr_reader :code, :total_quantity, :catalogue, :bundles

  def initialize(options={})
    @code           = options[:code]
    @total_quantity = options[:total_quantity]
    @catalogue      = options[:catalogue]
    @bundles        = create_bundles
  end

  def create_bundles
    product_bundles = catalogue.find(code)['bundles'].keys
    selected = select_bundle(product_bundles, total_quantity)
    convert_to_hash(product_bundles, selected)
  end

  def convert_to_hash(product_bundles, selected)
    bundles = {}
    product_bundles.each_with_index do |bundle, i|
      bundles[bundle] = selected[i]
    end
    delete_zero_bundles(bundles)
  end

  def delete_zero_bundles(bundles)
    bundles.each do |k,v|
      bundles.delete(k) if v == 0
    end
    bundles
  end
end
