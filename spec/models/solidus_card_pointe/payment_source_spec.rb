require 'spec_helper'

RSpec.describe SolidusCardPointe::PaymentSource, type: :model do
  describe '#populate_card_details' do
    let(:payment_source) { described_class.new(card_token: card_token) }

    before { payment_source.send(:populate_card_details) }

    context 'when card_token starts with 93' do
      let(:card_token) { '9312345678901234' }

      it 'sets card_type to Amex' do
        expect(payment_source.card_type).to eq('Amex')
      end

      it 'sets card_last4 to the last 4 digits of card_token' do
        expect(payment_source.card_last4).to eq('1234')
      end
    end

    context 'when card_token starts with 94' do
      let(:card_token) { '9412345678901234' }

      it 'sets card_type to Visa' do
        expect(payment_source.card_type).to eq('Visa')
      end

      it 'sets card_last4 to the last 4 digits of card_token' do
        expect(payment_source.card_last4).to eq('1234')
      end
    end

    context 'when card_token starts with 95' do
      let(:card_token) { '9512345678901234' }

      it 'sets card_type to MasterCard' do
        expect(payment_source.card_type).to eq('MasterCard')
      end

      it 'sets card_last4 to the last 4 digits of card_token' do
        expect(payment_source.card_last4).to eq('1234')
      end
    end

    context 'when card_token starts with 96' do
      let(:card_token) { '9612345678901234' }

      it 'sets card_type to Discover' do
        expect(payment_source.card_type).to eq('Discover')
      end

      it 'sets card_last4 to the last 4 digits of card_token' do
        expect(payment_source.card_last4).to eq('1234')
      end
    end

    context 'when card_token starts with an unknown prefix' do
      let(:card_token) { '0012345678901234' }

      it 'sets card_type to Unknown' do
        expect(payment_source.card_type).to eq('Unknown')
      end

      it 'sets card_last4 to the last 4 digits of card_token' do
        expect(payment_source.card_last4).to eq('1234')
      end
    end
  end
end
