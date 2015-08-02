class Item
  def self.create(line)
    line = line.first.split(' ')
    code = line[1]
    quantity = line[0].to_i
    new(code: code, quantity: quantity)
  end

  attr_reader :code, :quantity

  def initialize(options={})
    @code     = options[:code]
    @quantity = options[:quantity]
  end
end
