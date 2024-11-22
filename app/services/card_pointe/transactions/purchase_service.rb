# frozen_string_literal: true

module CardPointe
  module Transactions
    class PurchaseService < CardPointe::Transactions::BaseService
      def initialize(order, payment_source, payment_method)
        @order = order
        @payment_source = payment_source
        super(payment_method)
      end

      def call
        purchase
      end

      private

      def purchase
        url = "#{card_pointe_url}/auth"

        body = {
          merchid: card_pointe_merchant_id,
          account: @payment_source.card_token,
          amount: @order.total.to_s,
          currency: @order.currency,
          capture: 'y',
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
