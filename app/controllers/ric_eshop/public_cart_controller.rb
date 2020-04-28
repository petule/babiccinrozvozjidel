# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Cart
# *
# * Author: Matěj Outlý
# * Date  : 12. 11. 2015
# *
# *****************************************************************************

require_dependency "ric_eshop/public_controller"

module RicEshop
	class PublicCartController < PublicController
		include RicEshop::Concerns::Controllers::Public::CartController


	protected

		# 
		# Never trust parameters from the scary internet, only allow the white list through.
		#
		def cart_item_params
			params.permit([:product_id, :sub_product_ids, :restaurant_id].concat(params.keys.select { |key| key.to_s.start_with?("product_variant_") }))
		end
		
	end
end