require_relative 'upload_validator'
require_relative 'data_validator'

class Validator
  def self.validate(catalogue)
    UploadValidator.validate
    DataValidator.validate(catalogue)

    true
  end
end
