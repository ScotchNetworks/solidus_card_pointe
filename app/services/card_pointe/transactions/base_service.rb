# frozen_string_literal: true

module CardPointe
  module Transactions
    class BaseService
      CARD_POINTE_URL = 'cardconnect.com:6443/cardconnect/rest'

      def initialize(payment_method, **_args)
        @payment_method = payment_method
      end

      private

      def card_pointe_url
        "https://#{@payment_method.preferred_card_pointe_site}.#{CARD_POINTE_URL}"
      end

      def card_pointe_merchant_id
        @payment_method.preferred_card_pointe_merchant_id
      end

      def card_pointe_authorization
        @payment_method.preferred_card_pointe_authorization
      end

      def handle_response(result)
        return result.parsed_response if result.success?

        raise StandardError, result
      end
    end
  end
end
