class Customers::RegistrationsController < Devise::RegistrationsController
  
  include AddressConcern
  
  before_action :set_address_params, only: [:create, :update]
  before_action :set_last_orders, only: [:edit]

  #
  # Set session before action
  #
  before_action do
    @session = RicUser.session_model.find_or_create(RicUser.session_model.current_id(session))
  end

  #
  # Set cart before action
  #
  before_action do
    if @session
      @cart = @session.cart
    else
      @cart = RicEshop.cart_model.find(RicUser.session_model.current_id(session))
    end
  end
  
  layout 'application'
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |resource|
      if !address_present? || !save_addresses(resource)
        if resource.persisted?
          resource.destroy
        end
        resource.errors.add(:address, 'nebyla řádně vyplněna.')
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    if !validate_addresses(true)
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      resource.errors.add(:address, 'nebyla řádně vyplněna.')
      respond_with resource
    else
      super do |resource|
        if resource.errors.messages.size <=0 && !save_addresses(resource)
          resource.errors.add(:address, 'nebyla řádně vyplněna.')
          return
        end
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def set_address_params
    @address_params = address_params[:addresses]
  end
  
  def set_last_orders
    @orders = resource.orders.order(:created_at => :desc).limit(3)
  end
  
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
