# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Cart item
# *
# * Author: Matěj Outlý
# * Date  : 12. 11. 2015
# *
# *****************************************************************************

module RicEshop
	class CartItem < ActiveRecord::Base
		include RicEshop::Concerns::Models::CartItem
		
		#
		# One-to-many relation to restaurants
		#
		belongs_to :restaurant, class_name: "Restaurant"

	end
end

