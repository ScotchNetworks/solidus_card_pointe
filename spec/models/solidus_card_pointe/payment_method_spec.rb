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

    it 'has a domain preference' do
      expect(payment_method.has_preference?(:card_pointe_domain)).to be true
    end

    it 'returns the correct site for test server' do
      payment_method.preferred_server = 'test'
      payment_method.preferred_card_pointe_domain = 'example'
      expect(payment_method.preferred_card_pointe_site).to eq('example-uat')
    end

    it 'returns the correct site for live server' do
      payment_method.preferred_server = 'live'
      payment_method.preferred_card_pointe_domain = 'example'
      expect(payment_method.preferred_card_pointe_site).to eq('example')
    end
  end
end
