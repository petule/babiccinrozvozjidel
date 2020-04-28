class AddOpeningHoursToRetaurants < ActiveRecord::Migration
  def change
  	add_column :restaurants, :opening_hours_monday_min, :float
  	add_column :restaurants, :opening_hours_monday_max, :float
  	add_column :restaurants, :opening_hours_tuesday_min, :float
  	add_column :restaurants, :opening_hours_tuesday_max, :float
  	add_column :restaurants, :opening_hours_wednesday_min, :float
  	add_column :restaurants, :opening_hours_wednesday_max, :float
  	add_column :restaurants, :opening_hours_thursday_min, :float
  	add_column :restaurants, :opening_hours_thursday_max, :float
  	add_column :restaurants, :opening_hours_friday_min, :float
  	add_column :restaurants, :opening_hours_friday_max, :float
  	add_column :restaurants, :opening_hours_saturday_min, :float
  	add_column :restaurants, :opening_hours_saturday_max, :float
  	add_column :restaurants, :opening_hours_sunday_min, :float
  	add_column :restaurants, :opening_hours_sunday_max, :float
  	add_column :restaurants, :force_closed, :boolean
  end
end
