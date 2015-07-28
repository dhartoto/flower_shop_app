require 'products'

class FlowerShop
  attr_reader   :products
  attr_accessor :display

  def initialize
    @display  = file_upload_instructions
    @products = Products.all
  end

  private

  def file_upload_instructions
    "Please save Order CSV file into the 'uploads' folder then enter 1"\
      " to create invoice, or 2. to exit."
  end
end
