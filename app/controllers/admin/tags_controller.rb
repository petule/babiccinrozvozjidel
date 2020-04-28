# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Tags
# *
# * Author: Matěj Outlý
# * Date  : 10. 11. 2015
# *
# *****************************************************************************

class Admin::TagsController < AdminController

	before_action :set_tag, only: [:show, :edit, :update, :move, :destroy]

	#
	# Index action
	#
	def index
		@tags = Tag.all.order(position: :asc)
		respond_to do |format|
			format.html { render "index" }
			format.json { render json: @tags.to_json }
		end
	end

	#
	# Search action
	#
	def search
		@tags = Tag.search(params[:q]).order(position: :asc)
		respond_to do |format|
			format.html { render "index" }
			format.json { render json: @tags.to_json }
		end
	end

	#
	# Show action
	#
	def show
		@products = RicAssortment.product_model.tagged_with(@tag.name)
		respond_to do |format|
			format.html { render "show" }
			format.json { render json: @tag.to_json }
		end
	end

	#
	# New action
	#
	def new
		@tag = Tag.new
	end

	#
	# Edit action
	#
	def edit
	end

	#
	# Create action
	#
	def create
		@tag = Tag.new(tag_params)
		if @tag.save
			respond_to do |format|
				format.html { redirect_to main_app.admin_tag_path(@tag), notice: I18n.t("activerecord.notices.models.tag.create") }
				format.json { render json: @tag.id }
			end
		else
			respond_to do |format|
				format.html { render "new" }
				format.json { render json: @tag.errors }
			end
		end
	end

	#
	# Update action
	#
	def update
		if @tag.update(tag_params)
			respond_to do |format|
				format.html { redirect_to main_app.admin_tag_path(@tag), notice: I18n.t("activerecord.notices.models.tag.update") }
				format.json { render json: @tag.id }
			end
		else
			respond_to do |format|
				format.html { render "edit" }
				format.json { render json: @tag.errors }
			end
		end
	end

	#
	# Move action
	#
	def move
		if Tag.move(params[:id], params[:relation], params[:destination_id])
			respond_to do |format|
				format.html { redirect_to main_app.admin_tags_path, notice: I18n.t("activerecord.notices.models.tag.move") }
				format.json { render json: true }
			end
		else
			respond_to do |format|
				format.html { redirect_to main_app.admin_tags_path, alert: I18n.t("activerecord.errors.models.tag.move") }
				format.json { render json: false }
			end
		end
	end

	#
	# Destroy action
	#
	def destroy
		@tag.destroy
		respond_to do |format|
			format.html { redirect_to main_app.admin_tags_path, notice: I18n.t("activerecord.notices.models.tag.destroy") }
			format.json { render json: @tag.id }
		end
	end

protected

	#
	# Set model
	#
	def set_tag
		@tag = Tag.find_by_id(params[:id])
		if @tag.nil?
			redirect_to root_path, alert: I18n.t("activerecord.errors.models.tag.not_found")
		end
	end

	# 
	# Never trust parameters from the scary internet, only allow the white list through.
	#
	def tag_params
		params.require(:tag).permit(:name)
	end

end
