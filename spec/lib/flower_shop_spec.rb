require 'spec_helper'
require 'flower_shop'

describe FlowerShop do
  describe '.new' do
    before { allow(Catalogue).to receive(:create) }

    it { should be_an_instance_of(FlowerShop) }

    it 'should have instructions to display' do
      msg = " - Please save Order CSV file into the 'uploads' folder.\n"\
          " - Enter '1' to calculate costs and bundle breakdown\n"\
          " - Enter '2' to exit the Flower Shop App\n"

      expect(subject.response).to eq(msg)
    end
  end

  describe '#run' do
    let(:stubbed_response) { 'some message' }
    let(:order_engine) { instance_double('OrderEngine', response: stubbed_response) }

    before do
      allow(Catalogue).to receive(:create)
      allow(OrderEngine).to receive(:new) { order_engine }
      allow(Validator).to receive(:validate)
      allow(order_engine).to receive(:run)
    end

    context 'when user enters 1 to calculate costs and bundle' do
      before { allow(subject).to receive(:gets) { '1' } }

      it 'runs the order engine' do
        expect(order_engine).to receive(:run)

        subject.run
      end

      it 'displays message to user' do
        subject.run

        expect(subject.response).to eq(stubbed_response)
      end

      context 'when known errors are raised' do
        let(:mock_error_message) { 'error_message' }

        it 'displays file error message to user' do
          allow(Validator).to receive(:validate)
            .and_raise(Application::FileError, mock_error_message)

          subject.run

          expect(subject.response).to eq(mock_error_message)
        end

        it 'displays data error message to user' do
          allow(Validator).to receive(:validate)
            .and_raise(Application::DataError, mock_error_message)

          subject.run

          expect(subject.response).to eq(mock_error_message)
        end

        it 'displays order error message to user' do
          allow(Validator).to receive(:validate)
            .and_raise(Application::OrderError, mock_error_message)

          subject.run

          expect(subject.response).to eq(mock_error_message)
        end
      end
    end

    context 'when user enters 2 to exit program' do
      before { allow(subject).to receive(:gets) { '2' } }

      it 'does not fill order' do
        expect(OrderEngine).not_to receive(:new)

        subject.run
      end

      it 'displays exit message to user' do
        expected_response = "Exiting the Flower Shop"

        subject.run

        expect(subject.response).to eq(expected_response)
      end
    end

    context 'when user enters invalid entry' do
      it 'gets user input again' do
        allow(subject).to receive(:gets).and_return('wrong_input', '2')

        expect(subject).to receive(:gets).twice

        subject.run
      end
    end
  end
end
