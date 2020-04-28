# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Routing
# *
# * Author: Matěj Outlý
# * Date  : 11. 6. 2015
# *
# *****************************************************************************

Rails.application.routes.draw do

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'customers/login'
      post 'customers/register'
      get 'restaurants' => 'restaurants#index'
      get 'restaurants/:id/products' => 'restaurants#products'
    end
  end
  
  resource :addresses, only: [:destroy]
  
	scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

		#
		# Root
		#
		root "homepage#index"
		
		#
		# RIC User
		#
		mount RicUser::PublicEngine => "/user", as: :ric_user_public

		#
		# RIC Website
		#
		mount RicWebsite::PublicEngine => "/website", as: :ric_website_public

		#
		# RIC Eshop
		#
		mount RicEshop::PublicEngine => "/eshop", as: :ric_eshop_public

		#
		# RIC Payment
		#
		mount RicPaymentThepay::PublicEngine => "/payment", as: :ric_payment_public

		#
		# RIC Payment
		#
		mount RicPaymentFerbuy::PublicEngine => "/payment_ferbuy", as: :ric_payment_ferbuy_public

		#
		# RIC Advert
		#
		mount RicAdvert::PublicEngine => "/advert", as: :ric_advert_public

		#
		# Restaurants
		#
		resources "restaurants", only: [:show]

		#
		# Tags
		#
		resources "tags", only: [:show]

	end

	#
	# RIC Devise
	#
	#mount RicDevise::Engine => "/devise"
  devise_for :users, class_name: 'RicUser::User', controllers: {
		sessions: 'devise/sessions',
		passwords: 'devise/passwords',
		registrations: 'devise/registrations'
	}

	#
	# Admin root
	#
	get 'admin', to: "ric_admin/dashboard#index", as: :admin_root

	#
	# Specific admin
	#
	namespace :admin do

		#
		# Admin root
		#
		#root "restaurants#index"

		#
		# Restaurants
		#
		resources "restaurants" do
			member do
				put "move/:relation/:destination_id", action: "move", as: "move"
			end
		end

		#
		# Kitchen
		#
		resource "kitchen", only: [:show, :edit, :update]

		#
		# Maps
		#
		resources "delivery_maps"

		#
		# Map zones
		#
		resources "delivery_map_zones", except: [:index]

		#
		# Tags
		#
		resources :tags do
			member do
				put "move/:relation/:destination_id", action: "move", as: "move"
			end
			collection do
				get "search"
			end
		end

		#
		# Special actions
		#
		resources :special_actions, only: [:destroy] do
			member do
				put "move/:relation/:destination_id", action: "move", as: "move"
			end
    end
    
    #
    # Customers
    #
    resources :customers

	end

	#
	# RIC Admin
	#
	mount RicAdmin::Engine => "/admin/clockstar"

	#
	# RIC Account
	#
	mount RicAccount::Engine => "/admin/account"

	#
	# RIC User
	#
	mount RicUser::AdminEngine => "/admin/user", as: :ric_user_admin

	#
	# RIC Website
	#
	mount RicWebsite::AdminEngine => "/admin/website", as: :ric_website_admin
	
	#
	# RIC Assortment
	#
	mount RicAssortment::AdminEngine => "/admin/assortment", as: :ric_assortment_admin

	#
	# RIC Eshop
	#
	mount RicEshop::AdminEngine => "/admin/eshop", as: :ric_eshop_admin

	#
	# RIC Advert
	#
	mount RicAdvert::AdminEngine => "/admin/advert", as: :ric_advert_admin

	# *************************************************************************
	# Gateway
	# *************************************************************************

	#
	# RIC Payment FerBuy
	#
	mount RicPaymentFerbuy::GatewayEngine => "/gateway/payment_ferbuy", as: :ric_payment_ferbuy_gateway

end
