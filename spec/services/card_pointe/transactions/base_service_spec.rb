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
    context 'when response status is ok' do
      let(:success_result) { instance_double('Result', success?: true, parsed_response: { 'respstat' => 'A' }) }
      let(:failure_result) {
        instance_double('Result', success?: true,
          parsed_response: { 'respstat' => 'C', 'resptext' => 'wrong attribute' })
      }

      it 'returns parsed response if transaction is approved' do
        expect(service.send(:handle_response, success_result)).to eq({ 'respstat' => 'A' })
      end

      it 'calls handle_error if transaction is not approved' do
        allow(service).to receive(:handle_error).with(failure_result).and_return('wrong attribute')
        service.send(:handle_response, failure_result)
        expect(service).to have_received(:handle_error).with(failure_result)
      end
    end

    context 'when response status is not success' do
      let(:failure_result) {
        instance_double('Result', success?: false, parsed_response: nil, response: { 'message' => 'Unauthorized' })
      }

      it 'raises a StandardError if an error occurs' do
        allow(service).to receive(:handle_response).and_call_original
        allow(service).to receive(:handle_response).with(failure_result).and_raise(StandardError, 'StandardError')
        expect { service.send(:handle_response, failure_result) }.to raise_error(StandardError, 'StandardError')
      end
    end
  end
end
