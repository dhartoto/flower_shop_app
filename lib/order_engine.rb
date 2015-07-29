require 'order'
require 'packer'
require 'invoicer'

class OrderEngine
  attr_reader   :catalogue
  attr_accessor :response

  def initialize(catalogue)
    @catalogue = catalogue
    @order = Order.new(catalogue).create
  end

  def run
    package = Packer.pack(self)
    invoice = Invoicer.create(package)
    self.response = invoice.total
  end
end
