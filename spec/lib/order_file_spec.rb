require 'spec_helper'
require 'order_file'

describe OrderFile do
  describe '.get' do
    it 'assigns file to content attribute' do
      file = OrderFile.get
      expected_array = [["10 R12"], ["15 L09"], ["13 T58"]]
      expect(file.content).to eq(expected_array)
    end
  end
end
