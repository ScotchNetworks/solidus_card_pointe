# frozen_string_literal: true

module Spree
  module Admin
    module Payments
      module HideButtonForCardPointe
        def self.call
          Deface::Override.new(
            virtual_path: 'spree/admin/payments/new',
            original: 'fc5351424980b3983dce80c64d5d3aa059397d1f',
            name: 'hide_button_for_card_pointe',
            surround: '[data-hook="buttons"]',
            text: <<-ERB
              <div class="filter-actions actions" data-hook="buttons">
                <%= render_original %>
              </div>

              <script>
                document.addEventListener('DOMContentLoaded', function() {
                  var cardPointeIds = <%= Spree::PaymentMethod.where(type: 'SolidusCardPointe::PaymentMethod').pluck(:id) %>;
                  function toggleButton() {
                    var selectedMethod = document.querySelector('input[name="payment[payment_method_id]"]:checked');
                    var button = document.querySelector('[data-hook="buttons"] .btn');
                    if (selectedMethod && cardPointeIds.includes(parseInt(selectedMethod.value))) {
                      button.style.display = 'none';
                    } else {
                      button.style.display = 'inline-block';
                    }
                  }

                  toggleButton();

                  document.querySelectorAll('input[name="payment[payment_method_id]"]').forEach(function(radio) {
                    radio.addEventListener('change', toggleButton);
                  });
                });
              </script>
            ERB
          )
        end
      end
    end
  end
end

Spree::Admin::Payments::HideButtonForCardPointe.call
