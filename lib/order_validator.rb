require 'standard_validator'
require 'fillable'

class OrderValidator < StandardValidator
  class << self
    include Fillable
  end

  def self.validate(catalogue)
    errors = unfillable?(catalogue)
    error_message = errors ? get_error_message : nil
    status = errors ? 400 : 200
    new(status: status, error_message: error_message)
  end

  private

  def self.get_error_message
    "Error: Invalid order quantity. Please verify with client."
  end
end
