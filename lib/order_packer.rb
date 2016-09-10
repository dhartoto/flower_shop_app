require_relative 'pack'
require_relative 'order'
require_relative 'catalogue'

class OrderPacker
  def self.run(order, catalogue)
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
    order.items.inject([]) do |packs, item|
      packs << Pack.create(item, catalogue)
    end
  end
end
