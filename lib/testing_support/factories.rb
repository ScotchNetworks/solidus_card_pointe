# frozen_string_literal: true

FactoryBot.define do
  factory :card_pointe_payment_method, class: 'SolidusCardPointe::PaymentMethod' do
    name { 'Card Pointe' }
    available_to_admin { true }
    available_to_users { true }
    preferred_card_pointe_domain { 'fts' }
    preferred_card_pointe_merchant_id { 'merchant_id' }
    preferred_card_pointe_authorization { 'Basic fdjashdyut' }
  end
end
