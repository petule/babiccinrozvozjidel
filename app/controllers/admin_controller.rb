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

class AdminController < ApplicationController

	#
	# Authenticate before every action
	#
	before_action :authenticate_user!

	#
	# Layout
	#
	layout "ric_admin"

	#
	# Title component
	#
	component RicAdmin::TitleComponent

	#
	# Header logo component
	#
	component RicAdmin::HeaderLogoComponent

	#
	# Header menu component
	#
	component RicAdmin::HeaderMenuComponent
	
	#
	# Footer menu component
	#
	component RicAdmin::FooterMenuComponent

	#
	# Footer copy component
	#
	component RicAdmin::FooterCopyComponent
	
end