class Customer::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(:email, :password, :password_confirmation, :name_firstname, :name_lastname, :phone, :personal_data_agreement, :terms_agreement, :addresses_attributes => [ :street, :city, :zip, :country ])
  end

  def account_update
    default_params.permit(:email, :password, :password_confirmation, :current_password, :name_firstname, :name_lastname, :phone, :personal_data_agreement, :terms_agreement, :addresses_attributes => [ :street, :city, :zip, :country ])
  end
end