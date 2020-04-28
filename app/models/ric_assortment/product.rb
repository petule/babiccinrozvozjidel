# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Product
# *
# * Author: Matěj Outlý
# * Date  : 19. 6. 2015
# *
# *****************************************************************************

module RicAssortment
	class Product < ActiveRecord::Base
		include RicAssortment::Concerns::Models::Product

		# *********************************************************************
		# Structure
		# *********************************************************************

		#
		# Special actions
		#
		has_many :special_actions, class_name: "SpecialAction", dependent: :destroy, as: :owner
		accepts_nested_attributes_for :special_actions, :reject_if => lambda { |params| params[:title].blank? }, :allow_destroy => true

		# *********************************************************************
		# Tagging
		# *********************************************************************

		#
		# Enable tagging (tags attribute)
		#
		acts_as_taggable

		# *********************************************************************
		# Restaurant
		# *********************************************************************

		#
		# Get default restaurant
		#
		def restaurant
			if @restaurant.nil?
				@restaurant = Restaurant.where(product_collection_type: RicAssortment.product_category_model.to_s, product_collection_id: self.default_product_category_id).first
			end
			return @restaurant
		end

		# *********************************************************************
		# Structure
		# *********************************************************************

		#
		# Parts
		#
		def self.parts
			[:identification, :price, :meta, :categories, :photos, :variants, :special_actions]
		end

		#
		# Columns
		#	
		def self.identification_part_columns
			[:name, :name_fancy, :content, :amount]
		end
		
		#
		# Columns
		#
		def self.categories_part_columns
			[:tag_list, :product_category_ids, :product_ticker_ids]
		end

		#
		# Columns
		#	
		def self.special_actions_part_columns
			[:special_actions_attributes => [:id, :title, :color, :_destroy]]
		end

		# *********************************************************************
		# Name
		# *********************************************************************

		#
		# Basic name getter
		#
		def name
			result = read_attribute(:name)
			return result.trim(" \n\t").strip_tags
		end

		#
		# Fancy name getter
		#
		def name_fancy
			result = read_attribute(:name)
			if result
				return result.html_safe
			else
				return ""
			end
		end

		#
		# Fancy name setter
		#
		def name_fancy=(value)
			write_attribute(:name, value)
		end

	end
end
