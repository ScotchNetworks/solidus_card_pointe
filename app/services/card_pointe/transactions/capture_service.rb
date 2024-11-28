# frozen_string_literal: true

module CardPointe
  module Transactions
    class CaptureService < CardPointe::Transactions::BaseService
      def initialize(payment_method, payment_source, amount, currency)
        @amount = amount
        @currency = currency
        @payment_source = payment_source
        super(payment_method)
      end

      def call
        capture
      end

      private

      def capture
        url = "#{card_pointe_url}/auth"

        body = {
          merchid: card_pointe_merchant_id,
          amount: @amount.to_s,
          account: @payment_source.card_token,
          currency: @currency,
          capture: 'Y',
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
