# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Policy for observer controllers
# *
# * Author: Matěj Outlý
# * Date  : 30. 11. 2015
# *
# *****************************************************************************

class ObserverPolicy < Struct.new(:user, :observer)
	
	def show?
		return !user.nil? && (user.role == "observer" || user.role == "admin")
	end

end