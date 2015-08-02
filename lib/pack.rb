require 'fillable'

class Pack
  include Fillable

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
    available_bundles = catalogue.find(code)['bundles'].keys
    combinations = less_than_or_equal_to_combinations(available_bundles, total_quantity)
    matches = find_matches(combinations, available_bundles, total_quantity)
    selected = matches.sort {|x,y| sum(x) <=> sum(y) }.first

    bundles = {}
    available_bundles.each_with_index do |bundle, i|
      bundles[bundle] = selected[i]
    end
    bundles.each do |k,v|
      bundles.delete(k) if v == 0
    end
    bundles
  end
end
