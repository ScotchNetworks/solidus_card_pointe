require 'spec_helper'

RSpec.describe CardPointe::Transactions::AuthorizeService, :vcr do
  let(:order) { create(:order, total: 100.0, currency: 'USD') }
  let(:payment_method) { FactoryBot.create(:card_pointe_payment_method) }
  let(:payment_source) {
    instance_double('PaymentSource', payment_method: payment_method, card_token: '4111111111111111')
  }

  let(:service) { described_class.new(order, payment_source, payment_method) }

  describe '#call' do
    context 'when the authorize request is successful' do
      it 'returns a 200 status code for a successful authorize request', :vcr do
        VCR.use_cassette('card_pointe/authorize_success') do
          response = service.call
          expect(response).to include('retref')
        end
      end
    end

    context 'when the authorize request fails' do
      let(:payment_method) {
        FactoryBot.create(:card_pointe_payment_method, preferred_card_pointe_authorization: 'wrong-auth')
      }

      it 'raises an error for a failed authorize request', :vcr do
        VCR.use_cassette('card_pointe/authorize_failure') do
          expect { service.call }.to raise_error(StandardError)
        end
      end
    end
  end
end
