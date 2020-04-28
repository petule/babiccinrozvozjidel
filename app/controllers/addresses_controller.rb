class AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def destroy
    current_customer.addresses.destroy(params[:format])
    redirect_to :back
  end
end
