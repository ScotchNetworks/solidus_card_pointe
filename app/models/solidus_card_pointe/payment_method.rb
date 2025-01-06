# frozen_string_literal: true

module SolidusCardPointe
  class PaymentMethod < Spree::PaymentMethod
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

    def reusable_sources(order)
      return [] unless order.user

      order.user.wallet.wallet_payment_sources.map(&:payment_source).select(&:reusable?).select do |source|
        source.payment_method.is_a?(self.class)
      end
    end
  end
end
