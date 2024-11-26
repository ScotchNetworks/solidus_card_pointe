# frozen_string_literal: true

module SolidusCardPointe
  module PaymentDecorator
    def can_void?
      super && state == 'pending'
    end

    Spree::Payment.prepend(self)
  end
end
