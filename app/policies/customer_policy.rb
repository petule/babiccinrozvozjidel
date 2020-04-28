# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Policy for customer controllers
# *
# * Author: Matěj Outlý
# * Date  : 30. 11. 2015
# *
# *****************************************************************************

class CustomerPolicy < Struct.new(:user, :customer)
	
	def show?
		return !user.nil? && (user.role == "customer" || user.role == "admin")
	end

end