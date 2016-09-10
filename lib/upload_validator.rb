require_relative 'base_validator'

class UploadValidator < BaseValidator
  def self.validate(*arg)
    errors = !File.exists?(FULL_PATH) || File.zero?(FULL_PATH)
    error_message = errors ? get_error_message : nil
    status = errors ? 400 : 200
    new(status: status, error_message: error_message)
  end

  private

  def self.get_error_message
    if !File.exists?(FULL_PATH)
      "Error: File not found. Please save order.csv to public/uploads"\
        "folder."
    else
      "Error: File empty. Please check content of order.csv."
    end
  end
end
