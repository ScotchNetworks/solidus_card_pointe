# frozen_string_literal: true

require_dependency 'solidus_card_pointe'

module SolidusCardPointe
  class PaymentSource < SolidusSupport.payment_source_parent_class
    before_save :populate_card_details

    def reusable?
      true
    end

    def display_number
      "#{card_token[1..2]}XX-XXXX-XXXX-#{card_last4}"
    end

    private

    def populate_card_details
      self.card_type = determine_card_type
      self.card_last4 = card_token[-4..-1]
    end

    def determine_card_type
      case card_token[0..1]
      when '93'
        'Amex'
      when '94'
        'Visa'
      when '95'
        'MasterCard'
      when '96'
        'Discover'
      else
        'Unknown'
      end
    end
  end
end
