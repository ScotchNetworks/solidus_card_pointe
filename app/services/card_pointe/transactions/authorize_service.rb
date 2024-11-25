# frozen_string_literal: true

module CardPointe
  module Transactions
    class AuthorizeService < CardPointe::Transactions::BaseService
      def initialize(order, payment_source, payment_method)
        @order = order
        @payment_source = payment_source
        super(payment_method)
      end

      def call
        authorize
      end

      private

      def authorize
        url = "#{card_pointe_url}/auth"

        body = {
          merchid: card_pointe_merchant_id,
          account: @payment_source.card_token,
          amount: @order.amount.to_f,
          currency: @order.currency,
          name: @order.number,
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
