require 'csv'
require 'pry'

class OrderFile
  FILE_NAME = 'order.csv'
  FULL_PATH = "public/uploads/#{FILE_NAME}"

  def self.get(catalogue)
    if file_errors? || data_errors?(catalogue) || unfillalbe?(catalogue)
      error_message = get_error_message
      new(error_message: error_message)
    else
      file = read_file
      new(content: file)
    end
  end

  attr_accessor :error_message, :content

  def initialize(options={})
    @content       = options[:content]
    @error_message = options[:error_message]
  end

  def valid?
    error_message.nil?
  end
  # [["10 R12"], ["15 L09"], ["13 T58"]]
  def self.unfillalbe?(catalogue)
    order_file = read_file
    resp = false
    order_file.each do |line|
      order = line.first.split(' ')
      order_qty = order[0].to_i
      product = catalogue.find(order[1])
      bundle_qty = product['bundles'].keys.sort { |x,y| y <=> x }

      remainder = order_qty
      while bundle_qty.size > 0 do
        bundle_qty.each do |bundle|
          remainder = remainder%bundle if remainder >= bundle
        end
        break if remainder == 0
        remainder = order_qty
        bundle_qty.shift
      end
      resp = true unless remainder == 0
    end
    resp
  end

  private

  def self.read_file
    CSV.read(FULL_PATH)
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
