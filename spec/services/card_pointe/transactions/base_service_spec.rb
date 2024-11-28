require 'spec_helper'

RSpec.describe CardPointe::Transactions::BaseService, type: :service do
  let(:payment_method) {
    instance_double(
      'PaymentMethod',
      preferred_card_pointe_site: 'testsite',
      preferred_card_pointe_merchant_id: '123456',
      preferred_card_pointe_authorization: 'auth_token'
    )
  }
  let(:service) { described_class.new(payment_method) }

  describe '#card_pointe_url' do
    it 'returns the correct CardPointe URL' do
      expect(service.send(:card_pointe_url)).to eq('https://testsite.cardconnect.com:6443/cardconnect/rest')
    end
  end

  describe '#card_pointe_merchant_id' do
    it 'returns the correct merchant ID' do
      expect(service.send(:card_pointe_merchant_id)).to eq('123456')
    end
  end

  describe '#card_pointe_authorization' do
    it 'returns the correct authorization token' do
      expect(service.send(:card_pointe_authorization)).to eq('Basic auth_token')
    end
  end

  describe '#handle_response' do
    let(:success_result) { instance_double('Result', success?: true, parsed_response: { 'status' => 'approved' }) }
    let(:failure_result) { instance_double('Result', success?: false) }

    it 'returns parsed response if result is successful' do
      expect(service.send(:handle_response, success_result)).to eq({ 'status' => 'approved' })
    end

    it 'raises an error if result is not successful' do
      expect { service.send(:handle_response, failure_result) }.to raise_error(StandardError)
    end
  end
end
