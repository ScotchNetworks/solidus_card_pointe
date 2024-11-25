# frozen_string_literal: true

module SolidusCardPointe
  class Gateway
    def initialize(options = {}); end

    def authorize(_amount, payment_source, gateway_options)
      order_number = gateway_options[:order_id].split('-').first
      order = fetch_spree_order(order_number)

      authorization_response = CardPointe::Transactions::AuthorizeService.new(
        order,
        payment_source,
        payment_source.payment_method
      ).call

      ActiveMerchant::Billing::Response.new(true, 'Transaction approved', payment_source.attributes,
        authorization: authorization_response['retref'])
    rescue StandardError => e
      ActiveMerchant::Billing::Response.new(false, e, {})
    end

    def purchase(_amount, _response_code, gateway_options)
      order_number = gateway_options[:order_id].split('-').first
      order = fetch_spree_order(order_number)
      payment_source = gateway_options[:originator].source
      gateway_options[:originator].payment_method

      authorization_response = CardPointe::Transactions::PurchaseService.new(
        order,
        payment_source,
        payment_source.payment_method
      ).call

      ActiveMerchant::Billing::Response.new(true, 'Transaction approved', payment_source.attributes,
        authorization: authorization_response['retref'])
    rescue StandardError => e
      ActiveMerchant::Billing::Response.new(false, e, {})
    end

    private

    def fetch_spree_order(order_number)
      Spree::Order.find_by(number: order_number)
    end
  end
end
