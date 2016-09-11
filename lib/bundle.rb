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
    @breakdown      = find_min_bundle
  end

private

  def find_min_bundle
    bundles_offered = catalogue.find(code)['bundles'].keys

    order_bundles_array = select_min_bundle_array(bundles_offered, order_quantity)

    convert_to_hash(bundles_offered, order_bundles_array)
  end

  def select_min_bundle_array(bundles, order)
    combinations = collect_bundles_less_than_or_equal_to_order(bundles, order)
    matches = find_matches(combinations, bundles, order)
    matches.sort {|x,y| sum(x) <=> sum(y) }.first
  end

  def collect_bundles_less_than_or_equal_to_order(bundles, order)
    start_at = 0
    end_at = bundles.size
    bundle_combination = Array.new(bundles.size, 0)
    tested_combinations = [bundle_combination]

    tested_combinations.each do |batch|
      bundle_combination = batch.dup

        (start_at...end_at).each do |index|
          while total_flowers_collected(bundle_combination, bundles) <= order do
            tested_combinations << bundle_combination.dup
            bundle_combination[index] += 1
          end

          bundle_combination = batch.dup unless index == end_at && collection_is_greater_than_order(bundle_combination, bundles, order)
          tested_combinations.uniq!
          start_at += 1
        end

      start_at = 1
    end
    tested_combinations.uniq
  end

  def total_flowers_collected(batches, bundles)
    total = 0
    batches.each_with_index do |count, index|
      total += bundles[index] * count
    end
    total
  end

  def find_matches(combinations, bundles, order)
    match = []
    combinations.each do |batch|
      match << batch if total_flowers_collected(batch, bundles) == order
    end
    match
  end

  def sum(array)
    array.inject{ |r,e| r + e }
  end

  def convert_to_hash(catalogue_bundles, bundle_array)
    bundles = {}
    catalogue_bundles.each_with_index do |bundle, index|
      bundles[bundle] = bundle_array[index]
    end
    delete_zero_bundles(bundles)
  end

  def delete_zero_bundles(bundles)
    bundles.each do |k,v|
      bundles.delete(k) if v == 0
    end
    bundles
  end
end
