module ApplicationHelper

	#
	# Get URL to background picture
	#
	def background_url
		if !@restaurant.nil? && @restaurant.background_picture.exists?
			return @restaurant.background_picture.url(:full)
		elsif !setting_get("theme").blank?
			return image_url("bg_#{setting_get("theme")}.jpg")
		else
			return image_url("bg_default.jpg")
		end
	end

end
