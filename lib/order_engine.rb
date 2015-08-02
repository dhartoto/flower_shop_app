require_relative 'order'
require_relative 'packer'
require_relative 'invoicer'
require_relative 'validator'

class OrderEngine
  attr_reader   :catalogue
  attr_accessor :response

  def initialize(catalogue)
    @catalogue = catalogue
  end

  def run
    resp = Validator.validate(catalogue)
    if resp.valid?
      order = Order.new
      order.create
      package = Packer.pack(order, catalogue)
      invoice = Invoicer.create(package)
      self.response = invoice.details
    else
      self.response = resp.error_message
    end
  end
end
