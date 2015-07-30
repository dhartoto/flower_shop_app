require 'csv'
require 'pry'

class OrderFile
  FILE_NAME = 'order.csv'
  FULL_PATH = "public/uploads/#{FILE_NAME}"

  def self.get(catalogue)
    if file_errors?
      error_message = get_error_message
      new(error_message: error_message)
    elsif data_errors?(catalogue)
      error_message = get_error_message
      new(error_message: error_message)
    else
      file = CSV.read(FULL_PATH)
      new(content: file)
    end
  end

  attr_accessor :error_message, :content

  def initialize(options={})
    @content       = options[:content]
    @error_message = options[:error_message]
  end

  def valid?; end

  private

  def self.data_errors?(catalogue)
    resp = false
    file = CSV.read(FULL_PATH)
    file.each do |line|
      line = line.first.split(' ')
      Integer(line[0]) rescue resp = true
      resp = true unless catalogue.find(line[1])
    end
    resp
  end

  def self.file_errors?
    !File.exists?(FULL_PATH) || File.zero?(FULL_PATH)
  end

  def self.get_error_message
    if !File.exists?(FULL_PATH)
      "Error: File not found. Please save order.csv to public/uploads"\
        "folder."
    elsif File.zero?(FULL_PATH)
      "Error: File empty. Please check content of order.csv."
    else
      "Error: Invalid data. Please check the content of order.csv"
    end
  end

end
