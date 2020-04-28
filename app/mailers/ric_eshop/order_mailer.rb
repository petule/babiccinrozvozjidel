# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Order mailer
# *
# * Author: Matěj Outlý
# * Date  : 13. 11. 2015
# *
# *****************************************************************************

module RicEshop
	class OrderMailer < ::ApplicationMailer
		
		default from: "no-reply@babiccinrozvozjidel.cz"

		def customer_acknowledge(order)
			@order = order
			mail(to: order.customer_email, subject: "Potvrzení objednávky")
		end

		def restaurant_notice(order)
			@order = order
			mail(to: RicWebsite::Helpers::SettingHelper.setting_get("restaurant_email"), subject: "Nová objednávka")
		end

	end
end
