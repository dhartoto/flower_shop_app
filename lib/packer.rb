require 'pack'

class Packer
  def self.pack(order, catalogue)
    new(order: order, catalogue: catalogue)
  end

  attr_reader   :order, :catalogue
  attr_accessor :packs

  def initialize(options={})
    @order     = options[:order]
    @catalogue = options[:catalogue]
    @packs = create_packs
  end

  def create_packs
    packs = []
    order.items.each do |item|
      packs << Pack.create(item, catalogue)
    end
    packs
  end
end
