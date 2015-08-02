class Invoicer
  attr_reader   :package, :details
  attr_accessor :total_value

  def self.create(package)
    new(package: package)
  end

  def initialize(options={})
    @package = options[:package]
    @total_value = 0
    @details = create_details
  end

  def create_details
    pack = package.packs.first
    available_bundles = pack.catalogue.find(pack.code)['bundles']
    packed_bundles = pack.bundles
    packed_bundles.each do |k,v|
      self.total_value += available_bundles[k] * v
    end
    create_details_output(pack, available_bundles, packed_bundles)
  end

  def create_details_output(pack, available_bundles, packed_bundles)
    product_total = 0
    product_breakdown = ""
    packed_bundles.each do |bundle, count|
      bundle_total = available_bundles[bundle] * count
      product_total += bundle_total
      product_breakdown += create_product_bundle_output(count, bundle, bundle_total)
    end
    product_summary = "#{pack.total_quantity} #{pack.code} $#{product_total}\n"
    product_summary + product_breakdown
  end

  def create_product_bundle_output(count, bundle, value)
    "\t#{ count } x #{ bundle } $#{ value }\n"
  end
end
