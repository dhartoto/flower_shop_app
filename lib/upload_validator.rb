require_relative 'base_validator'
require 'exceptions'

class UploadValidator < BaseValidator

  def self.validate
    validate_file_exists

    validate_file_content_present

    true
  end

private

  def self.validate_file_exists
    return if File.exists?(FULL_PATH)

    raise FlowerShop::FileError,
      "Error: File not found. Please save order.csv to public/uploads folder."
  end

  def self.validate_file_content_present
    return unless File.zero?(FULL_PATH)

    raise FlowerShop::FileError,
      "Error: File empty. Please check content of order.csv."
  end
end
