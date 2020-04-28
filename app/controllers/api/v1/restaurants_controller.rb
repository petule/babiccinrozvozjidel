class Api::V1::RestaurantsController < Api::V1::ApiController
  before_action :set_restaurant, except: [:index]
  
  def index
    restaurants = Restaurant.not_hidden.order(position: :asc)
    open_restaurants = []
    restaurants.each do |restaurant|
      open_restaurants << restaurant if restaurant.currently_open
    end

    render json: open_restaurants
  end
  
  def products
    category = RicAssortment::ProductCategory.find(@restaurant.id)
    products = category.products
    
    render json: products
  end
  
  protected
  
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end