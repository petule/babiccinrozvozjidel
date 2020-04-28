# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Session
# *
# * Author: Matěj Outlý
# * Date  : 26. 11. 2015
# *
# *****************************************************************************

require_dependency "ric_user/public_controller"

module RicUser
	class PublicSessionController < PublicController
		include RicUser::Concerns::Controllers::Public::SessionController

	protected

		#
		# Get path which should be followed after session is succesfully updated
		#
		def session_updated_path
			main_app.root_path
		end

		# 
		# Never trust parameters from the scary internet, only allow the white list through.
		#
		def session_params
			params.require(:session).permit(:location => [:latitude, :longitude, :address, :level])
		end

	end
end