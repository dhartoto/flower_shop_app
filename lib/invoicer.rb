class Invoicer
  attr_reader   :package, :details
  attr_accessor :total_value

  def self.create(package)
    new(package: package)
  end

  def initialize(options={})
    @package = options[:package]
    @details = create_details
  end

  def create_details
    packs = package.packs
    total_output = ""
    packs.each do |pack|
      available_bundles = pack.catalogue.find(pack.code)['bundles']
      packed_bundles = pack.bundles
      total_output += create_details_output(pack, available_bundles, packed_bundles)
    end
    total_output
  end

  def create_details_output(pack, available_bundles, packed_bundles)
    product_total = 0
    product_breakdown = ""
    packed_bundles.each do |bundle, count|
      bundle_total = (available_bundles[bundle] * count)
      product_total += bundle_total
      product_breakdown += create_product_bundle_output(count, bundle, bundle_total)
    end
    product_summary = "#{pack.total_quantity} #{pack.code} $#{product_total.round(2)}\n"
    product_summary + product_breakdown
  end

  def create_product_bundle_output(count, bundle, value)
    "\t#{ count } x #{ bundle } $#{ value }\n"
  end
end
