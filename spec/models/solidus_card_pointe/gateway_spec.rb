require 'spec_helper'

module SolidusCardPointe
  RSpec.describe Gateway, type: :model do
    let(:gateway) { described_class.new }
    let(:order) { create(:order) }
    let(:payment_source) { create(:credit_card) }
    let(:gateway_options) {
      { order_id: "#{order.number}-123", originator: create(:payment, order: order, source: payment_source) }
    }

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
  end
end
