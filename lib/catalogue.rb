require 'yaml'
require 'pry'

class Catalogue
  FILE_NAME = 'catalogue.yml'
  PATH = "data/" + FILE_NAME

  def self.create
    file = YAML.load_file(PATH)
    new(products: file)
  end

  attr_accessor :products

  def initialize(options={})
    @products = options[:products]
  end
end
