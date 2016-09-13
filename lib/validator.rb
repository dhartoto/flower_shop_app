require_relative 'upload_validator'
require_relative 'data_validator'

class Validator
  VALIDATORS = [UploadValidator, DataValidator]
  def self.validate
    VALIDATORS.each(&:validate)

    true
  end
end
