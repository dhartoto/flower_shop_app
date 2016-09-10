require_relative 'base_validator'
require_relative 'fillable'

class OrderValidator < BaseValidator
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
