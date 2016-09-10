require_relative 'order'
require_relative 'packer'
require_relative 'invoicer'

class OrderEngine
  attr_reader   :catalogue
  attr_accessor :response

  def initialize(catalogue)
    @catalogue = catalogue
  end

  def run
    order = Order.new
    order.create
    package = Packer.pack(order, catalogue)
    invoice = Invoicer.create(package)
    self.response = invoice.details
  end
end
