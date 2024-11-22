class RemoveAmountandCurrencyFromCardPointePaymentSources < ActiveRecord::Migration[7.0]
  def change
    remove_column :solidus_card_pointe_payment_sources, :amount, :decimal
    remove_column :solidus_card_pointe_payment_sources, :currency, :string
  end
end
