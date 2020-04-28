class Admin::CustomersController < AdminController
  
  include AddressConcern
  
  before_action :set_customers, only: [:index]
  before_action :set_customer, except: [:index]
  
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @customer.update(customer_params)
      save_addresses(@customer)
    end
    
    redirect_to :back
  end
  
  protected
  
  def set_customers
    @customers = Customer.all
  end
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(:email, :name_firstname, :name_lastname, :phone, :bonus)
  end
end