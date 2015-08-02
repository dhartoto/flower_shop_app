require_relative 'standard_validator'

class DataValidator < StandardValidator
  def self.validate(catalogue)
    errors = data_errors?(catalogue)
    error_message = errors ? get_error_message : nil
    status = errors ? 400 : 200
    new(status: status, error_message: error_message)
  end

  private

  def self.get_error_message
    "Error: Invalid data. Please check the content of order.csv"
  end

  def self.data_errors?(catalogue)
    resp = false
    file = read_file
    file.each do |line|
      line = line.first.split(' ')
      Integer(line[0]) rescue resp = true # check if first part is an integer
      resp = true unless catalogue.find(line[1]) # check if product code is valid
    end
    resp
  end
end
