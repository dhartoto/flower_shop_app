require_relative 'order_file'
require_relative 'item'

class Order
  attr_accessor :items

  def self.create
    items = get_items

    new(items: items)
  end

  def self.get_items
    file = OrderFile.get

    file.content.inject([]) do |items, line|
      items << Item.create(line)
    end
  end

  def initialize(options={})
    @items = options[:items]
  end
end
