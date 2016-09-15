models = File.expand_path("../models", __FILE__)
lib = File.expand_path("../lib", __FILE__)
$:.unshift(models, lib)

require 'flower_shop'

flower_shop = FlowerShop.new
flower_shop.run
