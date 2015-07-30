class Packer
  def self.pack(order)
    new(order)
  end

  attr_reader :order

  def initialize(order)
    @order = order
  end
end
