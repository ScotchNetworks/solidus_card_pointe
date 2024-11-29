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
        "Basic #{@payment_method.preferred_card_pointe_authorization}"
      end

      def handle_response(result)
        if result.success?
          result.parsed_response['respstat'] != 'A' ? handle_error(result) : result.parsed_response
        else
          handle_error(result)
        end
      end

      def handle_error(result)
        error_message = if result.parsed_response
                          result.parsed_response['resptext']
                        else
                          result.response.message
                        end
        raise StandardError, error_message
      end
    end
  end
end
