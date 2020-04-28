# This migration comes from ric_eshop (originally 20151112095800)
class CreateRicEshopOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      # Timestamps
      t.timestamps null: true
      
      # Link to cart
      t.string :session_id

      # Customer
      t.integer :customer_id
      t.string :customer_name
      t.string :customer_email
      t.string :customer_phone

      # Billing
      t.string :billing_name
      t.string :billing_address_street
      t.string :billing_address_number
      t.string :billing_address_postcode
      t.string :billing_address_city

      # Payment
      t.string :payment_session_id
      t.string :payment_type
      t.datetime :paid_at
      t.string :currency

    end
  end
end
