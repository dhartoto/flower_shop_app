require 'csv'

class BaseValidator
  FILE_NAME = 'order.csv'
  FULL_PATH = "public/uploads/#{FILE_NAME}"

  attr_reader :status, :error_message

  def initialize(options={})
    @status = options[:status]
    @error_message = options[:error_message]
  end

  def valid?
    status == 200
  end

  private

  def self.read_file
    CSV.read(FULL_PATH)
  end
end
