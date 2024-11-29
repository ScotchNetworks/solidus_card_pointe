require 'spec_helper'

RSpec.describe CardPointe::Transactions::VoidService, :vcr do
  let(:payment_method) { FactoryBot.create(:card_pointe_payment_method) }
  let(:transaction_reference) { '333963034628' }
  let(:amount) { 36.74 }

  let(:service) { described_class.new(payment_method, transaction_reference, amount) }

  describe '#call' do
    context 'when the void request is successful' do
      it 'returns a 200 status code for a successful void request', :vcr do
        VCR.use_cassette('card_pointe/void_success') do
          response = service.call
          expect(response).to include('retref')
        end
      end
    end

    context 'when the void request fails' do
      let(:payment_method) {
        FactoryBot.create(:card_pointe_payment_method, preferred_card_pointe_authorization: 'wrong-auth')
      }

      it 'raises an error for a failed void request', :vcr do
        VCR.use_cassette('card_pointe/void_failure') do
          expect { service.call }.to raise_error(StandardError)
        end
      end
    end
  end
end
