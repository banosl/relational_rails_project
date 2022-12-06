class StateCitiesController < ApplicationController
  def index
    # binding.pry
    sorted_alpha = params[:sort]
    size_query = params[:miles_squared].to_f
    # binding.pry
    @state = State.find(params[:state_id])
    @cities = @state.cities
    @cities = @cities.order(name: :asc) if sorted_alpha == "alphabetical"
    # binding.pry
    # @cities = @cities.where(size: > :size_query)
  end

  # def sort_alphabetical
  #   binding.pry
  #   self.order(name: :asc)
  # end

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
  params.require(:City).permit(:name,
                              :population, 
                              :owner_occupied_housing_unit_rate, 
                              :form_of_gov, 
                              :size, 
                              :median_household_income, 
                              :public_transit)
end
end