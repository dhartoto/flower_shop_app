require_relative 'fillable'

class Bundle
  include Fillable

  def self.create(item, catalogue)
    new(
      code: item.code,
      total_quantity: item.quantity,
      catalogue: catalogue
      )
  end

  attr_reader :code, :total_quantity, :catalogue, :breakdown

  def initialize(options={})
    @code           = options[:code]
    @total_quantity = options[:total_quantity]
    @catalogue      = options[:catalogue]
    @breakdown      = find_min_bundle
  end

  def find_min_bundle
    catalogue_bundles = catalogue.find(code)['bundles'].keys
    bundle_array = select_min_bundle_array(catalogue_bundles, total_quantity)
    convert_to_hash(catalogue_bundles, bundle_array)
  end

  def convert_to_hash(catalogue_bundles, bundle_array)
    bundles = {}
    catalogue_bundles.each_with_index do |bundle, index|
      bundles[bundle] = bundle_array[index]
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
