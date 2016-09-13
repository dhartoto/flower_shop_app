require_relative 'base_validator'
require_relative 'catalogue'

class DataValidator < BaseValidator
  def self.validate
    catalogue = Catalogue.create
    validate_file_content(catalogue)

    true
  end

private

  def self.validate_file_content(catalogue)
    file = read_csv_file
    
    file.each do |row|
      verify_product_code(row, catalogue)

      verify_quantity_format(row)
    end
  end

  def self.verify_product_code(row, catalogue)
    code = get_product_code(row)

    raise_data_error unless catalogue.find(code)
  end

  def self.get_product_code(row)
    arr = row.first.split(' ')

    arr[1]
  end

  def self.verify_quantity_format(row)
    quantity = get_quantity(row)

    Integer(quantity)
  rescue ArgumentError
    raise_data_error
  end

  def self.get_quantity(row)
    arr = row.first.split(' ')
    arr[0]
  end

  def self.raise_data_error
    raise Application::DataError,
      "Error: Invalid data. Please check the content of order.csv"
  end
end
