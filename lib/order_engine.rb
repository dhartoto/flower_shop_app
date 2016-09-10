require_relative 'order_packer'
require_relative 'output_generator'

class OrderEngine
  attr_reader   :order, :catalogue
  attr_accessor :response

  def initialize(order, catalogue)
    @order = order
    @catalogue = catalogue
  end

  def run
    package = get_minimum_order_bundles
    output = generate_output(package)
    
    self.response = output.details
  end

private

  def get_minimum_order_bundles
    OrderPacker.run(order, catalogue)
  end

  def generate_output(package)
    OutputGenerator.run(package)
  end
end
