# frozen-string-literal: true

# Restaurants Controller
class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    # no view (comes from new view)
    # this instance of review is created with validation errors
    @restaurant = Restaurant.new(restaurant_params)
    # we need to associate our review to a restaurant(restaurant_id)
    # because so far this is what we have: <Review id: nil, rating: 5, content: "amazing", restaurant_id: nil, created_at: nil, updated_at: nil>
    # in the console: new_review.restaurant = eatery

    # if not empty due to validations it will save. then:
    # raise
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      # we will stay in the create action but will display the template of the new page
      # the only difference is that i am not using the "new" instance of @review, i am
      # using the instance of review that failed to save.
      # we can look at this instance on rails c using new_review.errors.messages
      # simple form handles that
      # render renders some html, it renders a page
      # if THE SAVE fails it will render a new page, and what is this new page?
      # essentially my form.
      # this instance of @review has validations and will show errors
      # renders the "new" route, a new form
      render :new
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :category, :phone_number)
  end
end
