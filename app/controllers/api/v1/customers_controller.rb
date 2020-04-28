class Api::V1::CustomersController < Api::V1::ApiController
  skip_before_filter :authenticate_user_from_token!
  
  def login
    customer = Customer.where(email: @json['email']).first
    if !customer || !customer.valid_password?(@json['password'])
      render nothing: true, status: :unauthorized
    else
      render json: { api_token: customer.api_token }
    end
  end
  
  def register
    customer = Customer.new
    customer.email = @json['email']
    customer.password = @json['password']
    customer.name_firstname = @json['name_firstname']
    customer.name_lastname = @json['name_lastname']
    customer.personal_data_agreement = @json['personal_data_agreement']
    customer.terms_agreement = @json['terms_agreement']
    customer.phone = @json['phone']
    if customer.save
      render json: { api_token: customer.api_token }
    else
      render json: customer.errors, status: :expectation_failed
    end
  end
end