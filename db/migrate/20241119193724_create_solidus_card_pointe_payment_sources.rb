class CreateSolidusCardPointePaymentSources < ActiveRecord::Migration[7.2]
  def change
    create_table :solidus_card_pointe_payment_sources do |t|
      t.string  :card_token, null: false
      t.integer :payment_method_id, index: true
      t.decimal :amount, precision: 10, scale: 2
      t.string :currency
      t.timestamps
    end
  end
end
