require_relative 'bundle'
require_relative 'order'
require_relative 'catalogue'

class OrderPacker
  def self.run(order, catalogue)
    new(order: order, catalogue: catalogue)
  end

  attr_reader   :order, :catalogue
  attr_accessor :order_bundles

  def initialize(options={})
    @order     = options[:order]
    @catalogue = options[:catalogue]
    @order_bundles = create_order_bundles
  end

  def create_order_bundles
    order.items.inject([]) do |order_bundles, item|
      order_bundles << Bundle.create(item, catalogue)
    end
  end
end
