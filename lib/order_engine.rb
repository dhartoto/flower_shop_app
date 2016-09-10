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
    package = OrderPacker.run(order, catalogue)
    output = OutputGenerator.run(package)
    self.response = output.details
  end
end
