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

    user_input = get_user_input

    get_optimal_bundle_for_order if user_input == '1'

    self.display = 'Exiting the Flower Shop' if user_input == '2'
    puts display # display response from order filler or exit message
  end

private
  def get_user_input(input = nil)
    while not ['1', '2'].include?(input)
      puts display
      input = gets.chomp
    end
    input
  end

  def get_optimal_bundle_for_order
    order_engine = OrderEngine.new(catalogue)
    order_engine.run
    self.display = order_engine.response # expect error message or results
  end

  def user_instructions
    " - Please save Order CSV file into the 'uploads' folder.\n"\
    " - Enter '1' to calculate costs and bundle breakdown\n"\
    " - Enter '2' to exit the Flower Shop App\n"
  end
end
