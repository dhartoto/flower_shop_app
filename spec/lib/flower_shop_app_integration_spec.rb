require 'spec_helper'
require 'flower_shop'

describe "Flower Shop" do
  let(:app) { FlowerShop.new }
  
  let(:welcome_message) do
    <<-eos
Welcome to the Flower Shop App.
- Please save Order CSV file into the 'uploads' folder.
- Enter '1' to calculate costs and bundle breakdown
- Enter '2' to exit the Flower Shop App
eos
  end

  let(:bundle_breakdown) do
      <<-eos
10 R12 $12.99
\t1 x 10 $12.99
15 L09 $41.9
\t1 x 6 $16.95
\t1 x 9 $24.95
13 T58 $25.85
\t1 x 3 $5.95
\t2 x 5 $19.9
eos
  end

  let(:exit_message) { "Exiting the Flower Shop\n" }

  context "whne user selects '1'" do
    it "returns the cost and bundle breakdown of each product" do
      allow(STDIN).to receive(:gets) { '1' }

      expect { app.run }.to output(welcome_message + bundle_breakdown).to_stdout
    end
  end
  context "when user selects '2'" do
    it "exits the application" do
      allow(STDIN).to receive(:gets) { '2' }

      expect { app.run }.to output(welcome_message + exit_message).to_stdout
    end
  end
end
