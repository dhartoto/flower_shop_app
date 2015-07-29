class Order
  attr_reader   :catalogue
  attr_accessor :error_message

  def initialize(catalogue)
    @catalogue = catalogue
  end

  def valid?
  end
end
