class Pack
  def self.create(item)
    new(code: item.code, quantity: item.quantity)
  end

  attr_reader :code, :quantity

  def initialize(options={})
    @code = options[:code]
    @quantity = options[:quantity]
  end
end
