# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Policy for admin controllers
# *
# * Author: Matěj Outlý
# * Date  : 30. 11. 2015
# *
# *****************************************************************************

class AdminPolicy < Struct.new(:user, :admin)
	
	def show?
		return !user.nil? && user.role == "admin"
	end

end