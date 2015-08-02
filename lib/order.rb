require_relative 'order_file'
require_relative 'item'

class Order
  attr_accessor :items

  def initialize
    @items = Array.new
  end

  def create
    file = OrderFile.get
      file.content.each do |line|
        items << Item.create(line)
      end
    self
  end
end
