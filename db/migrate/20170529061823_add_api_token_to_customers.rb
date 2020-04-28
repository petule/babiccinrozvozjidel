class AddApiTokenToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :api_token, :string
    add_index :customers, :api_token, unique: true
    
    Customer.all.each do |customer|
      begin
        customer.api_token = Devise.friendly_token
        customer.save!
      rescue ActiveRecord::RecordInvalid => e
        # ignore old invalid records
      rescue ActiveRecord::RecordNotUnique => e
        retry
      end
    end
  end
end
