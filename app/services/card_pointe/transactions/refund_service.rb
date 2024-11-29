# frozen_string_literal: true

module CardPointe
  module Transactions
    class RefundService < CardPointe::Transactions::BaseService
      def initialize(payment_method, amount, transaction_reference)
        @amount = amount
        @retref = transaction_reference
        super(payment_method)
      end

      def call
        refund
      end

      private

      def refund
        url = "#{card_pointe_url}/refund"

        body = {
          merchid: card_pointe_merchant_id,
          retref: @retref,
          amount: @amount.to_i.to_s,
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
