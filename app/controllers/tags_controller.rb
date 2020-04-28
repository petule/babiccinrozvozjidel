# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Tags
# *
# * Author: Matěj Outlý
# * Date  : 13. 11. 2015
# *
# *****************************************************************************

class TagsController < PublicController
	
	#
	# Set model before some actions
	#
	before_action :set_tag, only: [:show]
	
	#
	# Implement broadcast which gathers all title messages
	#
	implement_broadcast :title

	#
	# Show action
	#
	def show
	end

protected
	
	#
	# Get title of current tag model (if any)
	#
	def receive_title(arguments)
		if @tag
			return @tag.name.upcase_first
		else
			return nil
		end
	end

	#
	# Set current set_tag model
	#
	def set_tag
		@tag = Tag.find_by_id(params[:id])
		if @tag.nil?
			redirect_to root_path, alert: I18n.t("activerecord.errors.models.tag.not_found")
		end
	end

end
