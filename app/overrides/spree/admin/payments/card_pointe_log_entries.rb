# frozen_string_literal: true

module Spree
  module Admin
    module Payments
      class CardPointeLogEntries
        def self.call
          Deface::Override.new(
            virtual_path: 'spree/admin/payments/_log_entries',
            name: 'card_pointe_log_entries',
            original: '5eb2952fa4ba1484a63e5abf53e4ed735761a7b2',
            replace: 'table#listing_log_entries',
            partial: 'spree/admin/payments/source_views/card_pointe_log_entries',
            disabled: false
          )
        end
      end
    end
  end
end

Spree::Admin::Payments::CardPointeLogEntries.call
