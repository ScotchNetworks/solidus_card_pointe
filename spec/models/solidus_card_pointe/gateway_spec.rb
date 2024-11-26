require 'spec_helper'

module SolidusCardPointe
  RSpec.describe Gateway, type: :model do
    let(:gateway) { described_class.new }
    let(:order) { create(:order) }
    let(:payment_source) { create(:credit_card) }
    let(:gateway_options) {
      { order_id: "#{order.number}-123", originator: create(:payment, order: order, source: payment_source) }
    }

    describe '#authorize' do
      it 'returns a successful response when authorization is approved' do
        authorize_service = instance_double(CardPointe::Transactions::AuthorizeService)
        allow(CardPointe::Transactions::AuthorizeService).to receive(:new).and_return(authorize_service)
        allow(authorize_service).to receive(:call).and_return('retref' => '12345')
        response = gateway.authorize(1000, payment_source, gateway_options)
        expect(response).to be_success
      end

      it 'returns the correct authorization code when authorization is approved' do
        authorize_service = instance_double(CardPointe::Transactions::AuthorizeService)
        allow(CardPointe::Transactions::AuthorizeService).to receive(:new).and_return(authorize_service)
        allow(authorize_service).to receive(:call).and_return('retref' => '12345')
        response = gateway.authorize(1000, payment_source, gateway_options)
        expect(response.authorization).to eq('12345')
      end

      it 'returns a failed response when an error occurs' do
        authorize_service = instance_double(CardPointe::Transactions::AuthorizeService)
        allow(CardPointe::Transactions::AuthorizeService).to receive(:new).and_return(authorize_service)
        allow(authorize_service).to receive(:call).and_raise(StandardError)
        response = gateway.authorize(1000, payment_source, gateway_options)
        expect(response).not_to be_success
      end
    end

    describe '#purchase' do
      it 'returns a successful response when purchase is approved' do
        purchase_service = instance_double(CardPointe::Transactions::PurchaseService)
        allow(CardPointe::Transactions::PurchaseService).to receive(:new).and_return(purchase_service)
        allow(purchase_service).to receive(:call).and_return('retref' => '67890')
        response = gateway.purchase(1000, 'response_code', gateway_options)
        expect(response).to be_success
      end

      it 'returns the correct authorization code when purchase is approved' do
        purchase_service = instance_double(CardPointe::Transactions::PurchaseService)
        allow(CardPointe::Transactions::PurchaseService).to receive(:new).and_return(purchase_service)
        allow(purchase_service).to receive(:call).and_return('retref' => '67890')
        response = gateway.purchase(1000, 'response_code', gateway_options)
        expect(response.authorization).to eq('67890')
      end

      it 'returns a failed response when an error occurs' do
        purchase_service = instance_double(CardPointe::Transactions::PurchaseService)
        allow(CardPointe::Transactions::PurchaseService).to receive(:new).and_return(purchase_service)
        allow(purchase_service).to receive(:call).and_raise(StandardError.new('Purchase error'))
        response = gateway.purchase(1000, 'response_code', gateway_options)
        expect(response).not_to be_success
      end
    end

    describe '#capture' do
      it 'returns a successful response when capture is approved' do
        capture_service = instance_double(CardPointe::Transactions::CaptureService)
        allow(CardPointe::Transactions::CaptureService).to receive(:new).and_return(capture_service)
        allow(capture_service).to receive(:call).and_return('retref' => '54321')
        response = gateway.capture(1000, 'authorization_code', gateway_options)
        expect(response).to be_success
      end

      it 'returns the correct capture code when capture is approved' do
        capture_service = instance_double(CardPointe::Transactions::CaptureService)
        allow(CardPointe::Transactions::CaptureService).to receive(:new).and_return(capture_service)
        allow(capture_service).to receive(:call).and_return('retref' => '54321')
        response = gateway.capture(1000, 'authorization_code', gateway_options)
        expect(response.authorization).to eq('54321')
      end

      it 'returns a failed response when an error occurs' do
        capture_service = instance_double(CardPointe::Transactions::CaptureService)
        allow(CardPointe::Transactions::CaptureService).to receive(:new).and_return(capture_service)
        allow(capture_service).to receive(:call).and_raise(StandardError.new('Capture error'))
        response = gateway.capture(1000, 'authorization_code', gateway_options)
        expect(response).not_to be_success
      end
    end

    describe '#void' do
      it 'returns a successful response when void is approved' do
        void_service = instance_double(CardPointe::Transactions::VoidService)
        allow(CardPointe::Transactions::VoidService).to receive(:new).and_return(void_service)
        allow(void_service).to receive(:call).and_return('retref' => '98765')
        response = gateway.void('response_code', gateway_options)
        expect(response).to be_success
      end

      it 'returns the correct void code when void is approved' do
        void_service = instance_double(CardPointe::Transactions::VoidService)
        allow(CardPointe::Transactions::VoidService).to receive(:new).and_return(void_service)
        allow(void_service).to receive(:call).and_return('retref' => '98765')
        response = gateway.void('response_code', gateway_options)
        expect(response.authorization).to eq('98765')
      end

      it 'returns a failed response when an error occurs' do
        void_service = instance_double(CardPointe::Transactions::VoidService)
        allow(CardPointe::Transactions::VoidService).to receive(:new).and_return(void_service)
        allow(void_service).to receive(:call).and_raise(StandardError.new('Void error'))
        response = gateway.void('response_code', gateway_options)
        expect(response).not_to be_success
      end
    end
  end
end
