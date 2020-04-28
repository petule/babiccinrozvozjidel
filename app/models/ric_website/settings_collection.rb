# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Settings collection
# *
# * Author: Matěj Outlý
# * Date  : 7. 10. 2015
# *
# *****************************************************************************

module RicWebsite
	class SettingsCollection < ActiveRecord::Base
		include RicWebsite::Concerns::Models::SettingsCollection

		#
		# Define available settings
		#
		
		setting "restaurant_email", :string, "eshop"
		setting "restaurant_phone", :string, "eshop"
		setting "restaurant_facebook", :string, "eshop"
		setting "restaurant_address", :string, "eshop"
		setting "online_payment_restriction", :double_range, "eshop"
		setting "online_payment_limit", :currency, "eshop"
		setting "bonus_percent", :integer, "eshop"
		
		setting "entrepreneur_name", :string, "contact"
		setting "entrepreneur_email", :string, "contact"
		setting "entrepreneur_phone", :string, "contact"
		setting "entrepreneur_address", :string, "contact"
		setting "entrepreneur_org_num", :string, "contact"

		setting "theme", :enum, "homepage", values: ["default", "christmas"]
		setting "banner_no_address_big", :string, "homepage"
		setting "banner_no_address_small", :string, "homepage"
		setting "banner_address_big", :string, "homepage"
		setting "banner_address_small", :string, "homepage"
		setting "search_line1", :string, "homepage"
		setting "search_line2", :string, "homepage"
		setting "search_line3", :string, "homepage"
		setting "main_text", :text, "homepage"

		def self.online_payment_restricted(time = nil)
			
			# Get compared time
			time = Time.current if time.nil?

			# Transform compared time to float representation
			time_as_float = time.hour.to_f + (time.min / 60)

			# Get settings
			min = RicWebsite::Helpers::SettingHelper.setting_get("online_payment_restriction_min").to_s.to_f
			max = RicWebsite::Helpers::SettingHelper.setting_get("online_payment_restriction_max").to_s.to_f

			if min == max
				return false
			elsif min > max # Over midnight
				return (min <= time_as_float && time_as_float <= 24.0) || (0.0 <= time_as_float && time_as_float <= max)
			else
				return (min <= time_as_float && time_as_float <= max)
			end
		end

	end
end

