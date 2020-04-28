# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Restaurant
# *
# * Author: Matěj Outlý
# * Date  : 11. 11. 2015
# *
# *****************************************************************************

class Restaurant < ActiveRecord::Base

	# *************************************************************************
	# Structure
	# *************************************************************************

	#
	# Product category or product ticker 
	#
	belongs_to :product_collection, polymorphic: true

	#
	# Delivery map
	#
	belongs_to :delivery_map

	#
	# Special actions
	#
	has_many :special_actions, dependent: :destroy, as: :owner
	accepts_nested_attributes_for :special_actions, :reject_if => lambda { |params| params[:title].blank? }, :allow_destroy => true

	#
	# Kitchen
	#
	def kitchen
		if @kitchen.nil?
			@kitchen = Kitchen.first
		end
		return @kitchen 
	end

	# *************************************************************************
	# Ordering
	# *************************************************************************

	enable_ordering

	# *************************************************************************
	# Name
	# *************************************************************************

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

	# *************************************************************************
	# Attachments
	# *************************************************************************

	#
	# Logo
	#
	has_attached_file :logo, :styles => { :small => "196x98>", :full => "300x150>" }
	validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

	#
	# Profile
	#
	#has_attached_file :profile_picture, :styles => { :full => "322x110#" }
	#validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/
	croppable_picture_column :profile_picture, styles: { full: "322x110#" }
	#add_methods_to_json :profile_picture_url NOT WORKING BECAUSE OF STI

	#
	# Background
	#
	has_attached_file :background_picture, :styles => { :thumb => "150x150#", :full => "1920x1920>" }
	validates_attachment_content_type :background_picture, :content_type => /\Aimage\/.*\Z/

	# *************************************************************************
	# Hidden
	# *************************************************************************

	def self.not_hidden
		where("hidden IS NULL OR hidden = false")
	end

	def self.hidden
		where("hidden = true")
	end

	# *************************************************************************
	# Opening hours
	# *************************************************************************

	range_column :opening_hours_monday
	range_column :opening_hours_tuesday
	range_column :opening_hours_wednesday
	range_column :opening_hours_thursday
	range_column :opening_hours_friday
	range_column :opening_hours_saturday
	range_column :opening_hours_sunday

	def open?(time = nil)
		return false if self.force_closed
		return false if self.kitchen.force_closed
		
		# Get compared time
		time = Time.current if time.nil?
		
		wday_today = time.wday
		wday_yesterday = time.wday-1
		wday_yesterday = 6 if wday_yesterday < 0

		# Get opening hours relevant for current week day
		wdays = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
		opening_hours_today = self.send("opening_hours_#{wdays[wday_today].to_s}") 
		opening_hours_yesterday = self.send("opening_hours_#{wdays[wday_yesterday].to_s}") 
		
		# Transform compared time to float representation
		time_as_float = time.hour.to_f + (time.min / 60)

		result = false

		# Compare with opening hours today
		if result == false && !opening_hours_today.nil?
			if opening_hours_today[:min] > opening_hours_today[:max] # Open over midnight
				opening_hours_today[:max] = 24.0
			end
			result = (opening_hours_today[:min] <= time_as_float && time_as_float <= opening_hours_today[:max])
		end

		# Compare with opening hours yesterday
		if result == false && !opening_hours_yesterday.nil?
			if opening_hours_yesterday[:min] > opening_hours_yesterday[:max] # Open over midnight
				opening_hours_yesterday[:min] = 0.0
				result = (opening_hours_yesterday[:min] <= time_as_float && time_as_float <= opening_hours_yesterday[:max])
			end
		end

		return result
	end

	def currently_open
		if @currently_open.nil?
			@currently_open = self.open?
		end
		return @currently_open
	end

	def closed?(time = nil)
		return !self.open?(time)
	end

	def currently_closed
		return !self.currently_open
	end

	# *************************************************************************
	# Slug
	# *************************************************************************

	#
	# URL remplate
	#
	URL = "/restaurants/:id"

	#
	# Genereate slugs after save
	#
	after_save :generate_slugs

	#
	# Destroy slugs before destroy
	#
	before_destroy :destroy_slugs, prepend: true

	#
	# Genereate slugs after save
	#
	def generate_slugs
		if !RicWebsite.slug_model.nil? && !self.name.blank?
			
			# Get all models relevant for slug
			slug_models = []
			slug_models << self

			# Compose URL
			url = URL.gsub(/:id/, self.id.to_s)
			tmp_uri = URI.parse(url)
			
			I18n.available_locales.each do |locale|
				translation = RicWebsite.slug_model.compose_translation(locale, models: slug_models, label: :name)
				RicWebsite.slug_model.add_slug(locale, tmp_uri.path, translation)
			end
		end
	end

	#
	# Destroy slugs before destroy
	#
	def destroy_slugs
		if !RicWebsite.slug_model.nil?
			url = URL.gsub(/:id/, self.id.to_s)
			tmp_uri = URI.parse(url)
			I18n.available_locales.each do |locale|
				RicWebsite.slug_model.remove_slug(locale, tmp_uri.path)
			end
		end
	end

protected
	
	# *************************************************************************
	# Product collection
	# *************************************************************************

	before_save do
		if self.product_collection_id
			self.product_collection_type = self.product_collection_type
		else
			self.product_collection_type = nil
		end
	end

	def product_collection_type
		RicAssortment.product_category_model.to_s
	end

end
