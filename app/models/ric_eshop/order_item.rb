# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Orde item
# *
# * Author: Matěj Outlý
# * Date  : 12. 11. 2015
# *
# *****************************************************************************

module RicEshop
	class OrderItem < ActiveRecord::Base
		include RicEshop::Concerns::Models::OrderItem
		include RicPayment::Concerns::Models::PaymentSubjectItem
		
		#
		# One-to-many relation to restaurants
		#
		belongs_to :restaurant, class_name: "Restaurant"

		#
		# Fancy product name getter
		#
		def product_name_fancy
			if self.product
				return self.product.name_fancy
			else
				return self.product_name
			end
		end

	end
end

