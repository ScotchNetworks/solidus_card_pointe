# frozen_string_literal: true

module SolidusCardPointe
  class PaymentMethod < SolidusSupport.payment_method_parent_class
    preference :card_pointe_merchant_id, :string
    preference :card_pointe_authorization, :string
    preference :card_pointe_url, :string

    def gateway_class
      ::SolidusCardPointe::Gateway
    end

    def payment_source_class
      ::SolidusCardPointe::PaymentSource
    end

    def partial_name
      'card_pointe'
    end
  end
end
