require 'pack'

class Packer
  def self.pack(order)
    new(order)
  end

  attr_reader   :order
  attr_accessor :packs

  def initialize(order)
    @order = order
    @packs = create_packs
  end

  def create_packs
    packs = []
    order.items.each do |item|
      packs << Pack.create(item)
    end
    packs
  end
end
