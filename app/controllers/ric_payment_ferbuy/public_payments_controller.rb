# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Payments
# *
# * Author: Matěj Outlý
# * Date  : 29. 6. 2016
# *
# *****************************************************************************

require_dependency "ric_payment_ferbuy/public_controller"

module RicPaymentFerbuy
	class PublicPaymentsController < PublicController
		include RicPaymentFerbuy::Concerns::Controllers::Public::PaymentsController

		def success_path
			ric_eshop_public.finalize_order_path(@payment_subject)
		end

		def failed_path
			ric_eshop_public.finalize_order_path(@payment_subject)
		end

	end
end