require 'products'
require 'order_filler'

class FlowerShop
  attr_reader   :products
  attr_accessor :display

  def initialize
    @display  = file_upload_instructions
    @products = Products.all
  end

  def run
    user_input = nil
    puts 'Welcome to the Flower Shop App.'
    puts display # input instructions

    while not ['1', '2'].include?(user_input)
      puts display
      user_input = gets.chomp
    end

    if user_input == '1'
      order_filler = OrderFiller.fill(self)
      self.display = order_filler.message # breakdown or error message
    end
    self.display = 'Exiting the Flower Shop' if user_input == '2'
    puts display # display response from order filler or exit message
  end

  private

  def file_upload_instructions
    "Please save Order CSV file into the 'uploads' folder then enter"\
      " '1' to calculate costs and bundle breakdown, or '2' to exit."
  end
end
