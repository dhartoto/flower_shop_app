require_relative 'catalogue'
require_relative 'order_engine'
require_relative 'validator'

class FlowerShop
  attr_accessor :response

  def initialize
    @response  = user_instructions
  end

  def run
    puts 'Welcome to the Flower Shop App.'

    user_input = get_user_input

    get_optimal_bundle_for_order if user_input == '1'

    exit_flower_shop_app if user_input == '2'

    puts response
  end

private

  def get_user_input(input = nil)
    while not ['1', '2'].include?(input)
      puts response
      input = gets.chomp
    end
    input
  end

  def get_optimal_bundle_for_order
    validate_uploaded_file
    catalogue = Catalogue.create
    order = Order.create
    order_engine = OrderEngine.new(order, catalogue)
    order_engine.run
    self.response = order_engine.response
  rescue Application::FileError, Application::DataError, Application::OrderError => e

    self.response = e.message
  end

  def validate_uploaded_file
    Validator.validate
  end

  def exit_flower_shop_app
    self.response = 'Exiting the Flower Shop'
  end

  def user_instructions
    " - Please save Order CSV file into the 'uploads' folder.\n"\
    " - Enter '1' to calculate costs and bundle breakdown\n"\
    " - Enter '2' to exit the Flower Shop App\n"
  end
end
