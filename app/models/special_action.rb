# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Special action
# *
# * Author: 
# * Date  : 3. 3. 2016
# *
# *****************************************************************************

class SpecialAction < ActiveRecord::Base

	# *************************************************************************
	# Structure
	# *************************************************************************

	#
	# Restaurant or product
	#
	belongs_to :owner, polymorphic: true

	# *************************************************************************
	# Ordering
	# *************************************************************************

	enable_ordering

	# *************************************************************************
	# Enums
	# *************************************************************************

	enum_column :color, ["red", "green", "blue", "yellow", "orange"]
	
end