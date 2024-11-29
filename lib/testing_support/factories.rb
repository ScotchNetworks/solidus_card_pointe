# frozen_string_literal: true

FactoryBot.define do
  factory :card_pointe_payment_method, class: 'SolidusCardPointe::PaymentMethod' do
    name { 'Card Pointe' }
    available_to_admin { true }
    available_to_users { true }
    preferred_card_pointe_domain { ENV['CARD_POINTE_DOMAIN'] }
    preferred_card_pointe_merchant_id { ENV['CARD_POINTE_MERCHANT_ID'] }
    preferred_card_pointe_authorization { ENV['CARD_POINTE_AUTHORIZATION'] }
  end
end
