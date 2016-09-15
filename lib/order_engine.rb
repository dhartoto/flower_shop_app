require_relative 'order_packer'
require_relative 'output_generator'
require_relative 'order'
require_relative 'catalogue'

class OrderEngine
  attr_reader   :order, :catalogue
  attr_accessor :response

  def initialize(order=Order.create, catalogue=Catalogue.create)
    @order = order
    @catalogue = catalogue
  end

  def run
    order_packer = get_minimum_order_bundles
    output = generate_output(order_packer)

    self.response = output.packed_order_details
  end

private

  def get_minimum_order_bundles
    OrderPacker.run(order, catalogue)
  end

  def generate_output(order_packer)
    OutputGenerator.run(order_packer)
  end
end
