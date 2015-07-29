require 'csv'

module Customer

  class File
    FILE_NAME = 'order.csv'
    FULL_PATH = "public/uploads/#{FILE_NAME}"

    def self.get
      file = CSV.read(FULL_PATH)
      new(content: file)
    end

    attr_accessor :error_message, :content

    def initialize(options={})
      @content = options[:content]
    end

    def valid?
    end
  end
end
