# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Common features of application controllers
# *
# * Author: Matěj Outlý
# * Date  : 12. 5. 2015
# *
# *****************************************************************************

class PublicController < ApplicationController

	#
	# URL for helper method
	#
	def url_for(options = {})
		return RicWebsite::Helpers::SlugHelper.slugify(RicWebsite::Helpers::LocaleHelper.localify(super(options)))
	end
	helper_method :url_for

	
	def new_customer_session_path
		'/customers/sign_in'
	end
	helper_method :new_customer_session_path

	def new_customer_registration_path
		'/customers/sign_up'
	end
	helper_method :new_customer_registration_path

	def edit_customer_registration_path(customer)
		"/customers/edit.#{customer.id}"
	end
	helper_method :edit_customer_registration_path

	def destroy_customer_session_path(customer)
		'/customers/sign_out'
	end
	helper_method :destroy_customer_session_path
	

	#
	# Menu component
	#
	component RicWebsite::MenuComponent

	#
	# Languages component
	#
	component RicWebsite::LanguagesComponent

	#
	# Footer menu component
	#
	component RicWebsite::FooterMenuComponent

	#
	# Languages component
	#
	component RicWebsite::TitleComponent

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

end