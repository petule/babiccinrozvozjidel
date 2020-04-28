# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Texts
# *
# * Author: Matěj Outlý
# * Date  : 13. 5. 2015
# *
# *****************************************************************************

require_dependency "ric_website/admin_controller"

module RicWebsite
	class AdminTextsController < AdminController
		include RicWebsite::Concerns::Controllers::Admin::TextsController
	end
end
