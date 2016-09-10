require 'csv'

class BaseValidator
  FILE_NAME = 'order.csv'
  FULL_PATH = "public/uploads/#{FILE_NAME}"

  def self.read_csv_file
    CSV.read(FULL_PATH)
  end
end
