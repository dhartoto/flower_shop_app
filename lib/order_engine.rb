require_relative 'order_packer'
require_relative 'invoicer'

class OrderEngine
  attr_reader   :order, :catalogue
  attr_accessor :response

  def initialize(order, catalogue)
    @order = order
    @catalogue = catalogue
  end

  def run
    package = OrderPacker.run(order, catalogue)
    invoice = Invoicer.create(package)
    self.response = invoice.details
  end
end
