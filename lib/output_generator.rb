class OutputGenerator
  attr_reader   :order_packer, :details
  attr_accessor :total_value

  def self.run(order_packer)
    new(order_packer: order_packer)
  end

  def initialize(options={})
    @order_packer = options[:order_packer]
    @details = create_details
  end

  def create_details
    order_bundles = order_packer.order_bundles
    total_output = ""
    order_bundles.each do |bundle|
      available_bundles = bundle.catalogue.find(bundle.code)['bundles']
      bundle_breakdown = bundle.breakdown
      total_output += create_details_output(bundle, available_bundles, bundle_breakdown)
    end
    total_output
  end

  def create_details_output(bundle, available_bundles, bundle_breakdown)
    product_total = 0
    product_breakdown = ""
    bundle_breakdown.each do |bundle, count|
      bundle_total = (available_bundles[bundle] * count)
      product_total += bundle_total
      product_breakdown += create_product_bundle_output(count, bundle, bundle_total)
    end
    product_summary = "#{bundle.order_quantity} #{bundle.code} $#{product_total.round(2)}\n"
    product_summary + product_breakdown
  end

  def create_product_bundle_output(count, bundle, value)
    "\t#{ count } x #{ bundle } $#{ value }\n"
  end
end
