class AddCardInformationToPaymentSource < ActiveRecord::Migration[7.0]
  def change
    add_column :solidus_card_pointe_payment_sources, :card_last4, :string
    add_column :solidus_card_pointe_payment_sources, :card_type, :string
  end
end
