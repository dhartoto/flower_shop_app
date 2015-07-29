require 'customer'
require 'item'

class Order
  attr_reader   :catalogue
  attr_accessor :error_message, :items

  def initialize(catalogue)
    @catalogue = catalogue
    @items     = Array.new
  end

  def create
    file = Customer::File.retreive
    file.content.each do |line|
      items << Item.create(line)
    end
  end

  def valid?
  end
end
