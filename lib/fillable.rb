module Fillable

  def unfillable?(catalogue)
    order_file = read_file
    resp = false
    order_file.each do |line|
      line = line.first.split(' ')
      order = line[0].to_i
      product = catalogue.find(line[1])
      bundles = product['bundles'].keys.sort { |x,y| x <=> y }
      combinations = less_than_or_equal_to_combinations(bundles, order)
      matches = find_matches(combinations, bundles, order)
      resp = true if matches.empty?
    end
    resp
  end

  def select_bundle(bundles, order)
    combinations = less_than_or_equal_to_combinations(bundles, order)
    matches = find_matches(combinations, bundles, order)
    matches.sort {|x,y| sum(x) <=> sum(y) }.first
  end

  private

  def find_matches(combinations, bundles, order)
    match = []
    combinations.each do |batch|
      match << batch if total(batch, bundles) == order
    end
    match
  end

  def less_than_or_equal_to_combinations(bundles, order)
    start_at = 0
    end_at = bundles.size
    counter = Array.new(bundles.size, 0)
    possible_combinations = [counter.dup]
    inner_counter = counter.dup

    possible_combinations.each do |batch|
      inner_counter = batch.dup
      while start_at < end_at do
        (start_at...end_at).each do |index|

          while total(inner_counter, bundles) <= order do
            possible_combinations << inner_counter.dup if total(inner_counter, bundles) <= order
            inner_counter[index] += 1
          end

          inner_counter = batch.dup unless index == end_at and total(inner_counter, bundles) > order
          possible_combinations.uniq!
        end
        start_at += 1
      end
      start_at = 1
    end
    possible_combinations.uniq
  end

  def total(batches, bundles)
    total = 0
    batches.each_with_index do |count, index|
      total += bundles[index] * count
    end
    total
  end

  def sum(array)
    array.inject{ |r,e| r + e }
  end
end
