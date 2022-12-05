class CitiesController < ApplicationController
  def index
    @cities= City.all
  end
  
  def show
    @city = City.find(params[:id])
  end

  def edit
    @city = City.find(params[:id])
  end
  
  def update
    @city = City.find(params[:id])
    
    @city.update({
      name: params[:City][:name],
      population: params[:City][:population],
      owner_occupied_housing_unit_rate: params[:City][:owner_occupied_housing_unit_rate],
      form_of_gov: params[:City][:form_of_gov],
      size: params[:City][:size],
      median_household_income: params[:City][:median_household_income],
      public_transit: params[:City][:median_household_income]
    })
    
    @city.save
    redirect_to "/cities/#{@city.id}"
  end
end