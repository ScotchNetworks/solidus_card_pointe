# frozen_string_literal: true

module SolidusCardPointe
  class PaymentMethod < SolidusSupport.payment_method_parent_class
    preference :card_pointe_merchant_id, :string
    preference :card_pointe_authorization, :string
    preference :card_pointe_domain, :string

    UAT_URL_EXTENSION = '-uat'

    def gateway_class
      ::SolidusCardPointe::Gateway
    end

    def payment_source_class
      ::SolidusCardPointe::PaymentSource
    end

    def partial_name
      'card_pointe'
    end

    def preferred_card_pointe_site
      preferred_server == 'test' ? preferred_card_pointe_domain + UAT_URL_EXTENSION : preferred_card_pointe_domain
    end

    def try_void(payment)
      return false unless payment.source.can_void?(payment)

      gateway.void(payment.response_code, originator: payment)
    end
  end
end
