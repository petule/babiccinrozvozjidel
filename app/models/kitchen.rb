# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Kitchen
# *
# * Author: Matěj Outlý
# * Date  : 1. 3. 2016
# *
# *****************************************************************************

class Kitchen < ActiveRecord::Base

	#
	# Force closed picture
	#
	has_attached_file :force_closed_picture, :styles => { :thumb => "150x150>", :full => "450x450>" }
	validates_attachment_content_type :force_closed_picture, :content_type => /\Aimage\/.*\Z/

	#
	# Max delivery time
	#
	duration_column :max_delivery_time

	#
	# Restaurants
	#
	def restaurants
		if @restaurants.nil?
			@restaurants = Restaurant.all
		end
		return @restaurants 
	end

	#
	# Instance
	#
	def self.instance
		if @instance.nil?
			@instance = Kitchen.first
			if @instance.nil?
				@instance = Kitchen.create
			end
		end
		return @instance
	end

end
