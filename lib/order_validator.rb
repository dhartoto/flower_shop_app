require 'standard_validator'

class OrderValidator < StandardValidator

  def self.validate(catalogue)
    errors = unfillalbe?(catalogue)
    error_message = errors ? get_error_message : nil
    status = errors ? 400 : 200
    new(status: status, error_message: error_message)
  end

  private

  def self.unfillalbe?(catalogue)
    order_file = read_file
    resp = false
    order_file.each do |line|
      order = line.first.split(' ')
      order_qty = order[0].to_i
      product = catalogue.find(order[1])
      bundle_qty = product['bundles'].keys.sort { |x,y| y <=> x }

      remainder = order_qty
      while bundle_qty.size > 0 do
        bundle_qty.each do |bundle|
          remainder = remainder%bundle if remainder >= bundle
        end
        break if remainder == 0
        remainder = order_qty
        bundle_qty.shift
      end
      resp = true unless remainder == 0
    end
    resp
  end

  def self.get_error_message
    "Error: Invalid order quantity. Please verify with client."
  end
end
