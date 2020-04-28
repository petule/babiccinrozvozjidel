# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Tag
# *
# * Author: Matěj Outlý
# * Date  : 10. 11. 2015
# *
# *****************************************************************************

class Tag < ActiveRecord::Base

	# *************************************************************************
	# Ordering
	# *************************************************************************

	enable_ordering
	
	# *************************************************************************
	# Validators
	# *************************************************************************
	
	#
	# Name must be present
	#
	validates_presence_of :name

	# *************************************************************************
	# Scopes
	# *************************************************************************

	def self.search(query)
		if query.blank?
			all
		else
			#where("lower(unaccent(name)) LIKE ('%' || lower(unaccent(trim(:query))) || '%')", query: query)
			where("lower(name) LIKE ('%' || lower(trim(:query)) || '%')", query: query)
		end
	end

	# *************************************************************************
	# Slug
	# *************************************************************************

	#
	# URL remplate
	#
	URL = "/tags/:id"

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
	
end
