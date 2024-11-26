require 'spec_helper'

RSpec.describe CardPointe::Transactions::RefundService, :vcr do
  let(:amount) { 100.0 }
  let(:payment_method) { FactoryBot.create(:card_pointe_payment_method) }
  let(:transaction_reference) { '123456789' }

  let(:service) { described_class.new(payment_method, amount, transaction_reference) }

  describe '#call' do
    context 'when the refund request is successful' do
      it 'returns a 200 status code for a successful refund request', :vcr do
        VCR.use_cassette('card_pointe/refund_success') do
          response = service.call
          expect(response).to include('retref')
        end
      end
    end

    context 'when the refund request fails' do
      let(:payment_method) {
        FactoryBot.create(:card_pointe_payment_method, preferred_card_pointe_authorization: 'wrong-auth')
      }

      it 'raises an error for a failed refund request', :vcr do
        VCR.use_cassette('card_pointe/refund_failure') do
          expect { service.call }.to raise_error(StandardError)
        end
      end
    end
  end
end
