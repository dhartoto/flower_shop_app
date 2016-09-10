require_relative 'catalogue'
require_relative 'order_engine'

class FlowerShop
  attr_reader   :catalogue
  attr_accessor :display

  def initialize
    @display  = user_instructions
    @catalogue = Catalogue.create
  end

  def run
    user_input = nil
    puts 'Welcome to the Flower Shop App.'

    while not ['1', '2'].include?(user_input)
      puts display
      user_input = gets.chomp
    end

    if user_input == '1'
      order_engine = OrderEngine.new(catalogue)
      order_engine.run
      self.display = order_engine.response # expect error message or results
    end
    self.display = 'Exiting the Flower Shop' if user_input == '2'
    puts display # display response from order filler or exit message
  end

private

  def user_instructions
    " - Please save Order CSV file into the 'uploads' folder.\n"\
    " - Enter '1' to calculate costs and bundle breakdown\n"\
    " - Enter '2' to exit the Flower Shop App\n"
  end
end
