require 'spec_helper'

RSpec.describe SolidusCardPointe::PaymentMethod do
  let(:payment_method) { described_class.new }

  describe '#gateway_class' do
    it 'returns the correct gateway class' do
      expect(payment_method.gateway_class).to eq(::SolidusCardPointe::Gateway)
    end
  end

  describe '#payment_source_class' do
    it 'returns the correct payment source class' do
      expect(payment_method.payment_source_class).to eq(::SolidusCardPointe::PaymentSource)
    end
  end

  describe '#partial_name' do
    it 'returns the correct partial name' do
      expect(payment_method.partial_name).to eq('card_pointe')
    end
  end

  describe 'preferences' do
    it 'has a merchant_id preference' do
      expect(payment_method.has_preference?(:card_pointe_merchant_id)).to be true
    end

    it 'has an authorization preference' do
      expect(payment_method.has_preference?(:card_pointe_authorization)).to be true
    end

    it 'has a url preference' do
      expect(payment_method.has_preference?(:card_pointe_url)).to be true
    end
  end
end
