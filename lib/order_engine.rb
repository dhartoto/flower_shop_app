require 'order'

class OrderEngine
  attr_reader :response, :catalogue

  def initialize(catalogue)
    @catalogue = catalogue
    @order = Order.new(catalogue)
  end

  def run
  end
end
