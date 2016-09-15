require 'csv'

class OrderFile
  FILE_NAME = 'order.csv'
  FULL_PATH = "public/uploads/#{FILE_NAME}"

  def self.get
    content = read_file
    new(content: content)
  end

  attr_reader :content

  def initialize(options={})
    @content = options[:content]
  end

  private

  def self.read_file
    CSV.read(FULL_PATH)
  end
end
