class OutputGenerator
  attr_reader   :order_packer, :packed_order_details
  attr_accessor :total_value

  def self.run(order_packer)
    new(order_packer: order_packer)
  end

  def initialize(options={})
    @order_packer = options[:order_packer]
    @packed_order_details = create_output_for_packed_order
  end

  def create_output_for_packed_order
    order_bundles = order_packer.order_bundles
    packed_order_output = ""
    order_bundles.each do |bundle|
      packed_order_output += create_output_for_ordered_bundle(bundle)
    end
    packed_order_output
  end

  def create_output_for_ordered_bundle(bundle)
    prices = bundle.prices
    total_product_price = 0
    product_breakdown = ""
    bundle.breakdown.each do |bundle_offered, quantity|
      total_bundle_price = prices[bundle_offered] * quantity
      total_product_price += total_bundle_price
      product_breakdown += product_breakdown_to_string(quantity, bundle_offered, total_bundle_price)
    end
    product_summary = "#{bundle.order_quantity} #{bundle.code} $#{total_product_price.round(2)}\n"
    product_summary + product_breakdown
  end

  def product_breakdown_to_string(quantity, bundle_offered, value)
    "\t#{ quantity } x #{ bundle_offered } $#{ value }\n"
  end
end
