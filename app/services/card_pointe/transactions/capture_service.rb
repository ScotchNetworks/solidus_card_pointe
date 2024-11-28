# frozen_string_literal: true

module CardPointe
  module Transactions
    class CaptureService < CardPointe::Transactions::BaseService
      def initialize(payment_method, amount, currency, transaction_reference)
        @amount = amount
        @currency = currency
        @retref = transaction_reference
        super(payment_method)
      end

      def call
        capture
      end

      private

      def capture
        url = "#{card_pointe_url}/capture"

        body = {
          merchid: card_pointe_merchant_id,
          amount: @amount.to_s,
          currency: @currency,
          retref: @retref,
        }

        headers = {
          'Authorization' => card_pointe_authorization,
          'Content-Type' => 'application/json',
        }

        response = HTTParty.post(url, body: body.to_json, headers: headers)
        handle_response(response)
      end
    end
  end
end
