# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Delivery map
# *
# * Author: Matěj Outlý
# * Date  : 24. 11. 2015
# *
# *****************************************************************************

class DeliveryMap < ActiveRecord::Base

	# *************************************************************************
	# Structure
	# *************************************************************************

	has_many :delivery_map_zones

	# *************************************************************************
	# Validators
	# *************************************************************************
	
	validates_presence_of :name

end
