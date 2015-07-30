require 'order_file'
require 'item'

class Order
  attr_reader   :catalogue
  attr_accessor :error_message, :items

  def initialize(catalogue)
    @catalogue = catalogue
    @items     = Array.new
  end

  def create
    file = OrderFile.get(catalogue)
    if file.valid?
      file.content.each do |line|
        items << Item.create(line)
      end
    else
      self.error_message = file.error_message
    end
    self
  end

  def valid?
    error_message.nil?
  end
end
