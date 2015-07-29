require 'order'
require 'packer'
require 'invoicer'

class OrderEngine
  attr_reader   :catalogue, :order
  attr_accessor :response

  def initialize(catalogue)
    @catalogue = catalogue
    @order = Order.new(catalogue).create
  end

  def run
    if order.valid?
      package = Packer.pack(self)
      invoice = Invoicer.create(package)
      self.response = invoice.total
    else
      self.response = order.error_message
    end
  end
end
