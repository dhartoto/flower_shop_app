require 'csv'
require 'pry'

class OrderFile
  FILE_NAME = 'order.csv'
  FULL_PATH = "public/uploads/#{FILE_NAME}"

  def self.get
    if File.exists?(FULL_PATH)
      file = CSV.read(FULL_PATH)
      new(content: file)
    else
      error = "Error: File not found. Please save order.csv to public/uploads"\
        "folder."
      new(error_message: error)
    end
  end

  attr_accessor :error_message, :content

  def initialize(options={})
    @content       = options[:content]
    @error_message = options[:error_message]
  end

  def valid?
  end
end
