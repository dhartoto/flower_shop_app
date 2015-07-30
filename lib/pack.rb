class Pack
  def self.create(item, catalogue)
    new(
      code: item.code,
      total_quantity: item.quantity,
      catalogue: catalogue
      )
  end

  attr_reader :code, :total_quantity, :catalogue, :bundles

  def initialize(options={})
    @code           = options[:code]
    @total_quantity = options[:total_quantity]
    @catalogue      = options[:catalogue]
    @bundles        = create_bundles
  end

  def create_bundles
  end
end
