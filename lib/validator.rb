require_relative 'upload_validator'
require_relative 'data_validator'
require_relative 'order_validator'

class Validator
  VALIDATORS = [UploadValidator, DataValidator, OrderValidator]

  def self.validate(catalogue)
    status = 200
    error_message = nil

    VALIDATORS.each do |validator|
      resp = validator.validate(catalogue)
      if not resp.valid?
        error_message = resp.error_message
        status = 400
        break
      end
    end
    new(status: status, error_message: error_message)
  end

  attr_reader :status, :error_message

  def initialize(options={})
    @status = options[:status]
    @error_message = options[:error_message]
  end

  def valid?
    status == 200
  end
end
