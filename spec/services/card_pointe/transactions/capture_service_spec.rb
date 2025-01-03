require 'spec_helper'

RSpec.describe CardPointe::Transactions::CaptureService, :vcr do
  let(:amount) { 100.0 }
  let(:currency) { 'USD' }
  let(:payment_method) { FactoryBot.create(:card_pointe_payment_method) }
  let(:payment_source) {
    instance_double('PaymentSource', payment_method: payment_method, card_token: '9477257372660010')
  }

  let(:service) { described_class.new(payment_method, payment_source, amount, currency) }

  describe '#call' do
    context 'when the capture request is successful' do
      it 'returns a 200 status code for a successful capture request', :vcr do
        VCR.use_cassette('card_pointe/capture_success') do
          response = service.call
          expect(response).to include('retref')
        end
      end
    end

    context 'when the capture request fails' do
      let(:payment_method) {
        FactoryBot.create(:card_pointe_payment_method, preferred_card_pointe_authorization: 'wrong-auth')
      }

      it 'raises an error for a failed capture request', :vcr do
        VCR.use_cassette('card_pointe/capture_failure') do
          expect { service.call }.to raise_error(StandardError)
        end
      end
    end
  end
end
