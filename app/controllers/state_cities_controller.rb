class StateCitiesController < ApplicationController
  def index
    sorted_alpha = params[:sort]
    size_query = params[:miles_squared].to_f

    @state = State.find(params[:state_id])
    
    @cities = @state.cities
    @cities = @cities.cities_alphabetically if sorted_alpha == "alphabetical"
    @cities = @cities.city_size_query(size_query) if size_query != nil
  end

  def new
    @state = State.find(params[:state_id])
  end

  def create
    @state = State.find(params[:state_id])

    city = @state.cities.create!(state_cities_params)

    redirect_to "/states/#{@state.id}"
  end

  def destroy
    state = State.find(params[:state_id])
    City.destroy(params[:city_id])

    redirect_to("/states/#{state.id}/cities")
  end

private
  def state_cities_params
    params.permit(:name,
                  :population, 
                  :owner_occupied_housing_unit_rate, 
                  :form_of_gov, 
                  :size, 
                  :median_household_income, 
                  :public_transit)
  end
end