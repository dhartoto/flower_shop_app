class Bundle
  def self.create(item, catalogue)
    new(
      code: item.code,
      order_quantity: item.quantity,
      catalogue: catalogue
      )
  end

  attr_reader :code, :order_quantity, :catalogue, :breakdown

  def initialize(options={})
    @code           = options[:code]
    @order_quantity = options[:order_quantity]
    @catalogue      = options[:catalogue]
    @bundles_offered = catalogue.find(code)['bundles'].keys
    @breakdown      = find_min_bundle
  end

private
  attr_reader :bundles_offered

  def find_min_bundle
    order_bundle_array = select_min_bundle_array

    convert_to_hash(order_bundle_array)
  end

  def select_min_bundle_array
    matches = find_matching_bundles

    matches.sort {|x,y| sum(x) <=> sum(y) }.first
  end

  def find_matching_bundles
    starting_index = 0
    ending_index = bundles_offered.size
    bundle_counter = Array.new(bundles_offered.size, 0)
    collected_combinations = [bundle_counter]
    matching_bundles = []

    collected_combinations.each do |batch|

      (starting_index...ending_index).each do |index|
        while less_than_order_quantity?(bundle_counter) do
          dup_counter = bundle_counter.dup
          dup_counter[index] += 1
          collected_combinations << dup_counter unless collected_combinations.include?(dup_counter)

          matching_bundles << bundle_counter if bundle_match?(bundle_counter)
          bundle_counter = dup_counter
        end

        bundle_counter = batch.dup unless index == ending_index

        starting_index += 1
      end

      starting_index = 1
    end

    matching_bundles
  end

  def bundle_match?(bundle_counter)
    bundle_total(bundle_counter) == order_quantity
  end

  def less_than_order_quantity?(bundle_counter)
    bundle_total(bundle_counter) <= order_quantity
  end

  def bundle_total(bundle_counter)
    total = 0
    bundle_counter.each_with_index do |count, index|
      total += bundles_offered[index] * count
    end
    total
  end

  def sum(array)
    array.inject { |total, amount| total + amount }
  end

  def convert_to_hash(bundle_array)
    bundles = {}
    bundles_offered.each_with_index do |bundle, index|
      bundles[bundle] = bundle_array[index]
    end

    delete_zero_bundle(bundles)
  end

  def delete_zero_bundle(bundles)
    bundles.reject! {|bundle, amount| amount == 0}

    bundles
  end
end
