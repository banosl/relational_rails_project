class StateCitiesController < ApplicationController
  def index
    @state = State.find(params[:state_id])
    @cities = @state.cities
  end

  def new
    @state = State.find(params[:state_id])
  end

  def create
    @state = State.find(params[:state_id])

    city = @state.cities.create!({
      name: params[:City][:name],
      population: params[:City][:population],
      owner_occupied_housing_unit_rate: params[:City][:owner_occupied_housing_unit_rate],
      form_of_gov: params[:City][:form_of_gov],
      size: params[:City][:size],
      median_household_income: params[:City][:median_household_income],
      public_transit: params[:City][:median_household_income]
    })

    redirect_to "/states/#{@state.id}"
  end
end