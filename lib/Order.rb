class Order
  attr_reader   :catalogue
  attr_accessor :error_message, :items

  def initialize(catalogue)
    @catalogue = catalogue
    @items     = Array.new
  end

  def valid?
  end
end
