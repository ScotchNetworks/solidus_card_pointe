# frozen_string_literal: true

module CardPointe
  module Transactions
    class VoidService < CardPointe::Transactions::BaseService
      def initialize(payment_method, transaction_reference, amount)
        @retref = transaction_reference
        @amount = amount
        super(payment_method)
      end

      def call
        void
      end

      private

      def void
        url = "#{card_pointe_url}/void"

        body = {
          merchid: card_pointe_merchant_id,
          retref: @retref,
          amount: @amount.to_i.to_s
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
